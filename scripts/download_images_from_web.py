#!/usr/bin/env python3
"""Download image assets listed in IMAGE_CONTENTS.csv using Pexels search API.

Usage examples:
  python scripts/download_images_from_web.py --dry-run --limit 10
  python scripts/download_images_from_web.py --limit 50
  python scripts/download_images_from_web.py --overwrite

Required environment variable:
  PEXELS_API_KEY
"""

from __future__ import annotations

import argparse
import csv
import json
import os
import re
import sys
import time
from pathlib import Path
from typing import Dict, List, Optional, Tuple
from urllib.parse import urlencode
from urllib.request import Request, urlopen


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Search and download images from Pexels for paths in IMAGE_CONTENTS.csv",
    )
    parser.add_argument(
        "--root",
        default=".",
        help="Project root path (default: current directory)",
    )
    parser.add_argument(
        "--csv",
        default="assets/images/IMAGE_CONTENTS.csv",
        help="CSV file containing image paths and keywords",
    )
    parser.add_argument(
        "--report",
        default="assets/images/IMAGE_DOWNLOAD_REPORT.csv",
        help="Output report CSV path",
    )
    parser.add_argument(
        "--limit",
        type=int,
        default=0,
        help="Max number of rows to process (0 means all)",
    )
    parser.add_argument(
        "--delay",
        type=float,
        default=0.25,
        help="Delay in seconds between API calls (default: 0.25)",
    )
    parser.add_argument(
        "--overwrite",
        action="store_true",
        help="Overwrite files that already exist",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Do not download, only print what would happen",
    )
    parser.add_argument(
        "--country",
        default="Tunisia",
        help="Country keyword enforced in search queries (default: Tunisia)",
    )
    parser.add_argument(
        "--max-queries-per-image",
        type=int,
        default=6,
        help="How many fallback queries to try per image (default: 6)",
    )
    parser.add_argument(
        "--per-page",
        type=int,
        default=5,
        help="How many photos to request per query from Pexels (default: 5)",
    )
    return parser.parse_args()


def read_rows(csv_path: Path) -> List[Dict[str, str]]:
    if not csv_path.exists():
        raise FileNotFoundError(f"CSV not found: {csv_path}")

    with csv_path.open("r", encoding="utf-8-sig", newline="") as f:
        reader = csv.DictReader(f)
        rows = []
        for row in reader:
            rows.append({k: (v or "").strip() for k, v in row.items()})
    return rows


CATEGORY_HINTS = {
    "banner": "travel destination landscape",
    "onboarding": "travel storytelling lifestyle",
    "mockup": "travel concept editorial",
    "region-hero": "landscape drone view",
    "region-cover": "cityscape culture",
    "accommodation": "boutique hotel courtyard",
    "restaurant": "traditional food table",
    "artisan": "artisan workshop handmade",
    "activity": "outdoor activity adventure",
    "museum": "museum heritage architecture",
    "transport": "local transport street",
    "natureSpot": "nature panorama",
}


def pexels_search_first_image(
    query: str,
    api_key: str,
    per_page: int,
) -> Optional[str]:
    params = urlencode(
        {
            "query": query,
            "per_page": max(1, min(per_page, 15)),
            "orientation": "landscape",
            "size": "large",
        }
    )
    url = f"https://api.pexels.com/v1/search?{params}"

    req = Request(
        url,
        headers={
            "Authorization": api_key,
            "User-Agent": "hkeyetna-image-downloader/1.0",
        },
    )

    with urlopen(req, timeout=30) as resp:
        payload = json.loads(resp.read().decode("utf-8"))

    photos = payload.get("photos") or []
    if not photos:
        return None

    src = photos[0].get("src") or {}
    return src.get("large2x") or src.get("large") or src.get("original")


def download_file(url: str, destination: Path) -> None:
    destination.parent.mkdir(parents=True, exist_ok=True)

    req = Request(url, headers={"User-Agent": "hkeyetna-image-downloader/1.0"})
    with urlopen(req, timeout=60) as resp:
        data = resp.read()

    destination.write_bytes(data)


def normalize_spaces(value: str) -> str:
    return re.sub(r"\s+", " ", value).strip()


def dedupe_keep_order(items: List[str]) -> List[str]:
    seen = set()
    result: List[str] = []
    for item in items:
        key = normalize_spaces(item).lower()
        if not key or key in seen:
            continue
        seen.add(key)
        result.append(normalize_spaces(item))
    return result


def infer_region_from_row(row: Dict[str, str]) -> str:
    search_keywords = row.get("search_keywords", "")
    match = re.match(r"\s*([A-Za-z][A-Za-z\-\s]+?)\s+Tunisia\b", search_keywords)
    if match:
        return normalize_spaces(match.group(1))

    path_value = row.get("path", "")
    stem = Path(path_value).stem
    prefix = stem.split("_")[0] if "_" in stem else ""
    if prefix and prefix not in {"banner", "splash", "auth", "discover", "support", "travel", "tunisia"}:
        return normalize_spaces(prefix.replace("-", " ").title())

    return ""


def infer_base_category(row: Dict[str, str]) -> str:
    category = row.get("category", "").strip()
    if category.startswith("place-main-"):
        return category.replace("place-main-", "", 1)
    if category.startswith("place-gallery-"):
        return category.replace("place-gallery-", "", 1)
    return category


def build_query_candidates(row: Dict[str, str], country: str) -> List[str]:
    title = normalize_spaces(row.get("title", ""))
    description = normalize_spaces(row.get("description", ""))
    search_keywords = normalize_spaces(row.get("search_keywords", ""))
    region = infer_region_from_row(row)
    base_category = infer_base_category(row)
    category_hint = CATEGORY_HINTS.get(base_category, base_category.replace("-", " "))

    keyword_core = ", ".join([k.strip() for k in search_keywords.split(",")[:4] if k.strip()])
    title_core = " ".join(title.split()[:6])
    desc_core = " ".join(description.split()[:8])

    candidates = [
        f"{region} {country} {category_hint} travel photography",
        f"{region} {country} {title_core} authentic local",
        f"{country} {region} {keyword_core} editorial photo",
        f"{country} {category_hint} {title_core} real place",
        f"{country} {region} {desc_core}",
        f"{country} {category_hint} high quality landscape",
    ]

    cleaned = [normalize_spaces(item) for item in candidates]
    cleaned = [item for item in cleaned if item and country.lower() in item.lower()]
    return dedupe_keep_order(cleaned)


def process_row(
    row: Dict[str, str],
    root: Path,
    api_key: str,
    country: str,
    overwrite: bool,
    dry_run: bool,
    max_queries_per_image: int,
    per_page: int,
) -> Tuple[str, str, str]:
    rel_path = row.get("path", "").strip()
    if not rel_path:
        return "error", "missing_path", ""

    destination = root / rel_path
    if destination.exists() and not overwrite:
        return "skipped", "already_exists", ""

    queries = build_query_candidates(row, country)
    if not queries:
        return "error", "missing_query", ""

    queries = queries[: max(1, max_queries_per_image)]

    if dry_run:
        return "dry-run", " || ".join(queries), ""

    tried: List[str] = []
    for query in queries:
        tried.append(query)
        image_url = pexels_search_first_image(query, api_key, per_page)
        if image_url:
            download_file(image_url, destination)
            return "downloaded", query, image_url

    return "not-found", " || ".join(tried), ""


def write_report(report_path: Path, report_rows: List[Dict[str, str]]) -> None:
    report_path.parent.mkdir(parents=True, exist_ok=True)
    fieldnames = [
        "path",
        "status",
        "query_used_or_tried",
        "source_url",
        "note",
    ]
    with report_path.open("w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(report_rows)


def main() -> int:
    args = parse_args()
    root = Path(args.root).resolve()
    csv_path = root / args.csv
    report_path = root / args.report

    api_key = os.environ.get("PEXELS_API_KEY", "").strip()
    if not api_key and not args.dry_run:
        print("ERROR: PEXELS_API_KEY is missing.")
        print("Set it first, for example (PowerShell):")
        print("  $env:PEXELS_API_KEY = \"your_key_here\"")
        return 2

    try:
        rows = read_rows(csv_path)
    except Exception as exc:
        print(f"ERROR: {exc}")
        return 2

    total = len(rows)
    if args.limit and args.limit > 0:
        rows = rows[: args.limit]

    report_rows: List[Dict[str, str]] = []
    counters = {
        "downloaded": 0,
        "skipped": 0,
        "not-found": 0,
        "dry-run": 0,
        "error": 0,
    }

    print(f"Processing {len(rows)} rows (from total {total})")

    for idx, row in enumerate(rows, start=1):
        path_value = row.get("path", "")
        try:
            status, query_or_note, source_url = process_row(
                row=row,
                root=root,
                api_key=api_key,
                country=args.country,
                overwrite=args.overwrite,
                dry_run=args.dry_run,
                max_queries_per_image=args.max_queries_per_image,
                per_page=args.per_page,
            )
        except Exception as exc:
            status, query_or_note, source_url = "error", str(exc), ""

        counters[status] = counters.get(status, 0) + 1

        note = ""
        query_value = query_or_note
        if status == "error":
            note = query_or_note
            query_value = " || ".join(build_query_candidates(row, args.country))

        report_rows.append(
            {
                "path": path_value,
                "status": status,
                "query_used_or_tried": query_value,
                "source_url": source_url,
                "note": note,
            }
        )

        print(f"[{idx}/{len(rows)}] {status}: {path_value}")

        if idx < len(rows):
            time.sleep(max(0.0, args.delay))

    write_report(report_path, report_rows)

    print("Done")
    print(
        "Summary: "
        f"downloaded={counters.get('downloaded', 0)}, "
        f"skipped={counters.get('skipped', 0)}, "
        f"not-found={counters.get('not-found', 0)}, "
        f"dry-run={counters.get('dry-run', 0)}, "
        f"error={counters.get('error', 0)}"
    )
    print(f"Report: {report_path}")

    return 0


if __name__ == "__main__":
    sys.exit(main())
