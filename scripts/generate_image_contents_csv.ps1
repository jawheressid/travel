Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

$rowsByPath = @{}

function Add-Row {
  param(
    [string]$Path,
    [string]$Category,
    [string]$Source,
    [string]$Title,
    [string]$Description,
    [string]$Keywords
  )

  if ([string]::IsNullOrWhiteSpace($Path)) {
    return
  }

  if ($rowsByPath.ContainsKey($Path)) {
    return
  }

  $rowsByPath[$Path] = [PSCustomObject]@{
    path = $Path
    category = $Category
    source = $Source
    title = $Title
    description = $Description
    search_keywords = $Keywords
  }
}

$governorates = Get-Content "assets/data/governorates.json" -Raw | ConvertFrom-Json
$govById = @{}

foreach ($g in $governorates) {
  $govById[$g.id] = $g.name
  $tags = (($g.featured_tags | ForEach-Object { [string]$_ }) -join ', ')

  Add-Row -Path $g.hero_image -Category 'region-hero' -Source 'governorates.json' -Title "$($g.name) hero" -Description $g.description -Keywords "$($g.name) Tunisia landscape, $tags, hero"
  Add-Row -Path $g.cover_image -Category 'region-cover' -Source 'governorates.json' -Title "$($g.name) cover" -Description $g.description -Keywords "$($g.name) Tunisia city view, $tags, cover"
}

$banners = Get-Content "assets/data/banners.json" -Raw | ConvertFrom-Json
foreach ($b in $banners) {
  Add-Row -Path $b.image_path -Category 'banner' -Source 'banners.json' -Title $b.title -Description $b.subtitle -Keywords ("Tunisia travel banner, " + $b.title + ", " + $b.cta_label)
}

$datasets = @(
  'assets/data/places.json',
  'assets/data/activities.json',
  'assets/data/artisans.json'
)

foreach ($ds in $datasets) {
  $items = Get-Content $ds -Raw | ConvertFrom-Json
  foreach ($p in $items) {
    $gov = if ($govById.ContainsKey($p.governorate_id)) { $govById[$p.governorate_id] } else { 'Tunisia' }
    $tags = (($p.tags | ForEach-Object { [string]$_ }) -join ', ')
    $itemName = "$($p.name)"
    $itemType = "$($p.type)"
    $mainImage = "$($p.image_url)"
    $short = if ([string]::IsNullOrWhiteSpace("$($p.short_description)")) { "$($p.description)" } else { "$($p.short_description)" }
    $desc = ($short + ' ' + "$($p.description)").Trim()

    Add-Row -Path $mainImage -Category ("place-main-" + $itemType) -Source ([System.IO.Path]::GetFileName($ds)) -Title $itemName -Description $desc -Keywords ("$gov Tunisia, " + $itemType + ", " + $tags + ", local travel")

    if ($p.gallery_urls) {
      foreach ($u in $p.gallery_urls) {
        $gpath = [string]$u
        if ([string]::IsNullOrWhiteSpace($gpath)) {
          continue
        }

        $galleryTitle = if ($gpath -eq $mainImage) { $itemName } else { $itemName + ' gallery' }
        $galleryDesc = if ($gpath -eq $mainImage) { $desc } else { 'Secondary gallery view for ' + $itemName + ' in ' + $gov + '.' }

        Add-Row -Path $gpath -Category ("place-gallery-" + $itemType) -Source ([System.IO.Path]::GetFileName($ds)) -Title $galleryTitle -Description $galleryDesc -Keywords ("$gov Tunisia, " + $itemType + ", " + $tags + ", gallery")
      }
    }
  }
}

$uiRows = @(
  @{ path='assets/images/onboarding/auth_cover.jpg'; category='onboarding'; source='lib/auth'; title='Auth cover'; description='Welcoming visual for sign in and auth landing screens.'; keywords='Tunisia travelers, welcome, medina, lifestyle' },
  @{ path='assets/images/onboarding/discover_tunisia.jpg'; category='onboarding'; source='lib/onboarding'; title='Discover Tunisia'; description='Hero visual introducing Tunisia discovery journey.'; keywords='Tunisia travel aerial, medina, coast, discovery' },
  @{ path='assets/images/onboarding/support_locals.jpg'; category='onboarding'; source='lib/onboarding'; title='Support locals'; description='Visual about local artisans, community, and responsible tourism.'; keywords='Tunisian artisans, local community, handmade, workshop' },
  @{ path='assets/images/onboarding/travel_smart.jpg'; category='onboarding'; source='lib/onboarding'; title='Travel smart'; description='Visual about itinerary planning and meaningful travel.'; keywords='Tunisia route planning, smart travel, map, journey' },
  @{ path='assets/images/onboarding/splash_cover.jpg'; category='onboarding'; source='lib/splash'; title='Splash cover'; description='Main splash image for app launch screen.'; keywords='Tunisia iconic landscape, opening screen' },
  @{ path='assets/images/mockups/tunisia_map.jpg'; category='mockup'; source='lib/governorates'; title='Tunisia map'; description='Map visual used on governorates exploration page.'; keywords='Tunisia map outline, governorates map, transparent' },
  @{ path='assets/images/mockups/planner_cover.jpg'; category='mockup'; source='lib/planner'; title='Planner cover'; description='Cover image for trip planner experience.'; keywords='travel planner, Tunisia itinerary, notebook map' },
  @{ path='assets/images/mockups/horse_riding.jpg'; category='mockup'; source='lib/interests'; title='Horse riding interest'; description='Interest card image for horse riding activity.'; keywords='horse riding Tunisia, desert trail, adventure' },
  @{ path='assets/images/mockups/cycling.jpg'; category='mockup'; source='lib/interests'; title='Cycling interest'; description='Interest card image for cycling.'; keywords='cycling Tunisia, coastal road, bike trip' },
  @{ path='assets/images/mockups/nature.jpg'; category='mockup'; source='lib/interests'; title='Nature interest'; description='Interest card image for nature exploration.'; keywords='Tunisia nature, mountain, forest, landscape' },
  @{ path='assets/images/mockups/crafts.jpg'; category='mockup'; source='lib/interests'; title='Crafts interest'; description='Interest card image for local crafts.'; keywords='Tunisian crafts, pottery, weaving, handmade' },
  @{ path='assets/images/mockups/cuisine.jpg'; category='mockup'; source='lib/interests'; title='Cuisine interest'; description='Interest card image for traditional cuisine.'; keywords='Tunisian cuisine, couscous, brik, local food' },
  @{ path='assets/images/mockups/artisan.jpg'; category='mockup'; source='lib/interests'; title='Artisan interest'; description='Interest card image for handcrafted products.'; keywords='artisan Tunisia, workshop, handmade products' }
)

foreach ($u in $uiRows) {
  Add-Row -Path $u.path -Category $u.category -Source $u.source -Title $u.title -Description $u.description -Keywords $u.keywords
}

$rows = $rowsByPath.Values | Sort-Object path
$csvPath = "assets/images/IMAGE_CONTENTS.csv"
$rows | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

Write-Output "created=$csvPath"
Write-Output "rows=$($rows.Count)"
