import '../enums/app_enums.dart';
import '../models/app_banner.dart';
import '../models/governorate.dart';
import '../models/place.dart';
import '../models/travel_catalog.dart';

const List<String> curatedRegionOrder = ['bizerte', 'kef', 'tozeur'];
const List<String> curatedLeisureTags = [
  'Nature',
  'Heritage',
  'Food',
  'Artisanat',
  'Horse Riding',
  'Cycling',
  'Adventure',
  'Desert',
  'Sea',
  'Birdwatching',
  'Photography',
  'Wellness',
  'Family Friendly',
];

const String _categoryAccommodation = '10000000-0000-0000-0000-000000000001';
const String _categoryRestaurant = '10000000-0000-0000-0000-000000000002';
const String _categoryArtisan = '10000000-0000-0000-0000-000000000003';
const String _categoryActivity = '10000000-0000-0000-0000-000000000004';
const String _categoryMuseum = '10000000-0000-0000-0000-000000000005';
const String _categoryNatureSpot = '10000000-0000-0000-0000-000000000006';
const String _categoryTransport = '10000000-0000-0000-0000-000000000007';

const String bizerteGovernorateId = '20000000-0000-0000-0000-000000000007';
const String kefGovernorateId = '20000000-0000-0000-0000-000000000010';
const String tozeurGovernorateId = '20000000-0000-0000-0000-000000000023';

TravelCatalog applyCuratedContent(TravelCatalog catalog) {
  final governorates = catalog.governorates
      .map(
        (governorate) => switch (governorate.slug) {
          'bizerte' => governorate.copyWith(
            description:
                'Sea light, wetlands, UNESCO birdwatching, and medina heritage anchored by Ichkeul.',
            featuredTags: ['Sea', 'Birdwatching', 'Heritage'],
          ),
          'kef' => governorate.copyWith(
            name: 'Le Kef',
            description:
                'Kasbah heritage, highland panoramas, hiking routes, and regional food immersion in the northwest.',
            featuredTags: ['Heritage', 'Highlands', 'Hiking'],
          ),
          'tozeur' => governorate.copyWith(
            description:
                'Oasis architecture, desert cinema landscapes, canyon escapes, and premium Sahara stays.',
            featuredTags: ['Desert', 'Oasis', 'Cinema'],
          ),
          _ => governorate,
        },
      )
      .toList(growable: false);

  return TravelCatalog(
    governorates: governorates,
    categories: catalog.categories,
    places: _curatedPlaces,
    banners: _curatedBanners,
  );
}

extension CuratedTravelCatalogX on TravelCatalog {
  List<Governorate> get curatedGovernorates {
    final curated = governorates
        .where((governorate) => curatedRegionOrder.contains(governorate.slug))
        .toList();
    curated.sort(
      (left, right) => curatedRegionOrder
          .indexOf(left.slug)
          .compareTo(curatedRegionOrder.indexOf(right.slug)),
    );
    return curated;
  }

  List<Governorate> get inspirationGovernorates {
    return governorates
        .where((governorate) => !curatedRegionOrder.contains(governorate.slug))
        .toList(growable: false);
  }

  List<String> get curatedGovernorateIds {
    return curatedGovernorates
        .map((governorate) => governorate.id)
        .toList(growable: false);
  }
}

final List<AppBanner> _curatedBanners = [
  const AppBanner(
    id: '90000000-0000-0000-0000-100000000001',
    title: 'Bizerte sea and birdlife',
    subtitle:
        'Mix Ichkeul birdwatching, Cap Angela viewpoints, medina heritage, and coastal stays.',
    imagePath: 'assets/images/regions/bizerte_hero.jpg',
    ctaLabel: 'Explore Bizerte',
  ),
  const AppBanner(
    id: '90000000-0000-0000-0000-100000000002',
    title: 'Le Kef culture and highlands',
    subtitle:
        'Build routes around the Kasbah, the medina, Table de Jugurtha, and regional food.',
    imagePath: 'assets/images/regions/kef_hero.jpg',
    ctaLabel: 'Explore Le Kef',
  ),
  const AppBanner(
    id: '90000000-0000-0000-0000-100000000003',
    title: 'Tozeur desert experiences',
    subtitle:
        'Plan oasis walks, Star Wars locations, canyon escapes, and wellness-led desert stays.',
    imagePath: 'assets/images/regions/tozeur_hero.jpg',
    ctaLabel: 'Explore Tozeur',
  ),
  const AppBanner(
    id: '90000000-0000-0000-0000-100000000004',
    title: 'Multi-region custom programs',
    subtitle:
        'Generate adapted itineraries that combine more than one curated region in the same trip.',
    imagePath: 'assets/images/banners/banner_oasis.jpg',
    ctaLabel: 'Start planner',
  ),
];

final List<Place> _curatedPlaces = [
  _place(
    id: '31000000-0000-0000-0000-000000000001',
    governorateId: bizerteGovernorateId,
    categoryId: _categoryAccommodation,
    type: PlaceType.accommodation,
    name: 'Hotel Nour Congress & Resort',
    description:
        'A seafront Bizerte base for heritage weekends and family coastal stays near the corniche.',
    shortDescription:
        'Comfortable sea-facing resort for Bizerte city breaks and local excursions.',
    imageUrl: 'assets/images/places/bizerte_accommodation_1.jpg',
    galleryUrls: const [
      'assets/images/places/bizerte_accommodation_1.jpg',
      'assets/images/places/bizerte_accommodation_21.jpg',
    ],
    address: 'Bizerte Corniche',
    latitude: 37.2800,
    longitude: 9.8890,
    priceMin: 210,
    priceMax: 360,
    rating: 4.4,
    recommendationScore: 92,
    isFamilyFriendly: true,
    tags: ['Sea', 'Wellness', 'Family Friendly'],
    openingHours: '24/7',
  ),
  _place(
    id: '31000000-0000-0000-0000-000000000002',
    governorateId: bizerteGovernorateId,
    categoryId: _categoryAccommodation,
    type: PlaceType.accommodation,
    name: 'Bizerta Resort Congres & SPA',
    description:
        'A polished waterfront stay for sea and heritage weekends with spa facilities and easy marina access.',
    shortDescription:
        'Resort and spa stay designed for relaxing Bizerte weekends.',
    imageUrl: 'assets/images/places/bizerte_accommodation_2.jpg',
    galleryUrls: const [
      'assets/images/places/bizerte_accommodation_2.jpg',
      'assets/images/places/bizerte_accommodation_22.jpg',
    ],
    address: 'Route de la Corniche, Bizerte',
    latitude: 37.2850,
    longitude: 9.8800,
    priceMin: 260,
    priceMax: 420,
    rating: 4.5,
    recommendationScore: 94,
    isFamilyFriendly: true,
    tags: ['Sea', 'Wellness', 'Family Friendly'],
    openingHours: '24/7',
  ),
  _place(
    id: '31000000-0000-0000-0000-000000000003',
    governorateId: bizerteGovernorateId,
    categoryId: _categoryAccommodation,
    type: PlaceType.accommodation,
    name: 'Sally Glamping',
    description:
        'A lighter glamping base for travelers who want nature access between Ichkeul and the Bizerte coast.',
    shortDescription:
        'Glamping stay with strong nature, birdwatching, and photo-trip appeal.',
    imageUrl: 'assets/images/places/bizerte_accommodation_21.jpg',
    galleryUrls: const [
      'assets/images/places/bizerte_accommodation_21.jpg',
      'assets/images/places/bizerte_accommodation_22.jpg',
    ],
    address: 'Nature corridor near Ichkeul, Bizerte',
    latitude: 37.1650,
    longitude: 9.6800,
    priceMin: 170,
    priceMax: 280,
    rating: 4.6,
    recommendationScore: 95,
    isFamilyFriendly: true,
    tags: ['Nature', 'Birdwatching', 'Photography', 'Family Friendly'],
    openingHours: '24/7',
  ),
  _place(
    id: '31000000-0000-0000-0000-000000000004',
    governorateId: bizerteGovernorateId,
    categoryId: _categoryNatureSpot,
    type: PlaceType.natureSpot,
    name: 'Ichkeul National Park',
    description:
        'Tunisia'
        's flagship wetland reserve and UNESCO site for bird migration, soft hiking, and wildlife observation.',
    shortDescription:
        'Essential Bizerte nature stop for birdwatching, walks, and landscape photography.',
    imageUrl: 'assets/images/places/bizerte_naturespot_11.jpg',
    galleryUrls: const [
      'assets/images/places/bizerte_naturespot_11.jpg',
      'assets/images/places/bizerte_naturespot_31.jpg',
    ],
    address:
        'Parc national de l'
        'Ichkeul',
    latitude: 37.1630,
    longitude: 9.6730,
    priceMin: 25,
    priceMax: 60,
    rating: 4.8,
    recommendationScore: 98,
    isFamilyFriendly: true,
    tags: ['Nature', 'Birdwatching', 'Photography', 'Family Friendly'],
    openingHours: '08:00 - 18:00',
  ),
  _place(
    id: '31000000-0000-0000-0000-000000000005',
    governorateId: bizerteGovernorateId,
    categoryId: _categoryNatureSpot,
    type: PlaceType.natureSpot,
    name: 'Cap Angela Cliffs',
    description:
        'A panoramic stop at the northern tip of Africa with cliff views, sea air, and strong photo-trip value.',
    shortDescription:
        'Cap Angela viewpoints for sea scenery, photo stops, and light coastal walks.',
    imageUrl: 'assets/images/places/bizerte_naturespot_31.jpg',
    galleryUrls: const [
      'assets/images/places/bizerte_naturespot_31.jpg',
      'assets/images/places/bizerte_naturespot_11.jpg',
    ],
    address: 'Cap Angela, Bizerte',
    latitude: 37.3470,
    longitude: 9.7420,
    priceMin: 20,
    priceMax: 45,
    rating: 4.7,
    recommendationScore: 96,
    isFamilyFriendly: true,
    tags: ['Sea', 'Nature', 'Photography', 'Family Friendly'],
    openingHours: '08:00 - 19:00',
  ),
  _place(
    id: '31000000-0000-0000-0000-000000000006',
    governorateId: bizerteGovernorateId,
    categoryId: _categoryMuseum,
    type: PlaceType.museum,
    name: 'Bizerte Medina and Qsiba Walk',
    description:
        'A heritage route through the medina, old fortification fabric, and everyday stories around the harbor.',
    shortDescription:
        'Cultural walk linking the medina, Qsiba, and old-port heritage layers.',
    imageUrl: 'assets/images/places/bizerte_museum_9.jpg',
    galleryUrls: const [
      'assets/images/places/bizerte_museum_9.jpg',
      'assets/images/places/bizerte_museum_29.jpg',
    ],
    address: 'Medina de Bizerte',
    latitude: 37.2730,
    longitude: 9.8730,
    priceMin: 35,
    priceMax: 80,
    rating: 4.5,
    recommendationScore: 93,
    isFamilyFriendly: true,
    tags: ['Heritage', 'Photography', 'Family Friendly'],
    openingHours: '09:00 - 18:00',
  ),
  _place(
    id: '31000000-0000-0000-0000-000000000007',
    governorateId: bizerteGovernorateId,
    categoryId: _categoryMuseum,
    type: PlaceType.museum,
    name: 'Utique Heritage Circuit',
    description:
        'A guided combined circuit that adds archaeological context to Bizerte'
        's sea-and-history positioning.',
    shortDescription:
        'Combined heritage circuit for travelers who want Utique with Bizerte highlights.',
    imageUrl: 'assets/images/places/bizerte_museum_29.jpg',
    galleryUrls: const [
      'assets/images/places/bizerte_museum_29.jpg',
      'assets/images/places/bizerte_museum_9.jpg',
    ],
    address: 'Circuit from Bizerte to Utique',
    latitude: 37.1290,
    longitude: 10.0550,
    priceMin: 50,
    priceMax: 110,
    rating: 4.3,
    recommendationScore: 89,
    tags: ['Heritage', 'Photography'],
    openingHours: '09:00 - 17:00',
  ),
  _place(
    id: '31000000-0000-0000-0000-000000000008',
    governorateId: bizerteGovernorateId,
    categoryId: _categoryActivity,
    type: PlaceType.activity,
    name: 'Ichkeul Birdwatching Day',
    description:
        'A guided day built around seasonal bird migration, soft walking trails, and wildlife interpretation.',
    shortDescription:
        'Signature birdwatching outing with guide support and scenic wetland stops.',
    imageUrl: 'assets/images/places/bizerte_activity_7.jpg',
    galleryUrls: const [
      'assets/images/places/bizerte_activity_7.jpg',
      'assets/images/places/bizerte_activity_27.jpg',
    ],
    address: 'Departure from Bizerte to Ichkeul',
    latitude: 37.1700,
    longitude: 9.6900,
    priceMin: 95,
    priceMax: 180,
    rating: 4.8,
    recommendationScore: 98,
    isFamilyFriendly: true,
    tags: ['Birdwatching', 'Nature', 'Photography', 'Family Friendly'],
    openingHours: '07:00 - 16:30',
  ),
  _place(
    id: '31000000-0000-0000-0000-000000000009',
    governorateId: bizerteGovernorateId,
    categoryId: _categoryActivity,
    type: PlaceType.activity,
    name: 'Sea and Heritage Weekend',
    description:
        'A bookable Bizerte program mixing the old port, medina stories, and time on the coast in one package.',
    shortDescription:
        'Weekend-format package built around sea light, heritage, and local rhythm.',
    imageUrl: 'assets/images/places/bizerte_activity_28.jpg',
    galleryUrls: const [
      'assets/images/places/bizerte_activity_28.jpg',
      'assets/images/places/bizerte_activity_8.jpg',
    ],
    address: 'Bizerte old port and corniche',
    latitude: 37.2740,
    longitude: 9.8750,
    priceMin: 120,
    priceMax: 230,
    rating: 4.6,
    recommendationScore: 94,
    isFamilyFriendly: true,
    tags: ['Sea', 'Heritage', 'Photography', 'Family Friendly'],
    openingHours: '09:00 - 18:30',
  ),
  _place(
    id: '31000000-0000-0000-0000-000000000010',
    governorateId: bizerteGovernorateId,
    categoryId: _categoryActivity,
    type: PlaceType.activity,
    name: 'Ghar El Melh Coastal Escape',
    description:
        'A slower coastal outing blending lagoon scenery, local life, and optional cycling or boat moments.',
    shortDescription:
        'Authentic Ghar El Melh stay-and-explore format with coastal atmosphere.',
    imageUrl: 'assets/images/places/bizerte_activity_8.jpg',
    galleryUrls: const [
      'assets/images/places/bizerte_activity_8.jpg',
      'assets/images/places/bizerte_activity_27.jpg',
    ],
    address: 'Ghar El Melh, Bizerte',
    latitude: 37.1580,
    longitude: 10.1900,
    priceMin: 80,
    priceMax: 160,
    rating: 4.5,
    recommendationScore: 92,
    isFamilyFriendly: true,
    tags: ['Sea', 'Cycling', 'Photography', 'Family Friendly'],
    openingHours: '09:00 - 18:00',
  ),
  _place(
    id: '31000000-0000-0000-0000-000000000011',
    governorateId: bizerteGovernorateId,
    categoryId: _categoryActivity,
    type: PlaceType.activity,
    name: 'Vieux Port Kayak Session',
    description:
        'A coastal session built for calm-sea discovery, local guide support, and strong visual appeal around the port.',
    shortDescription:
        'Kayak and sea-discovery outing around Bizerte'
        's waterfront.',
    imageUrl: 'assets/images/places/bizerte_activity_27.jpg',
    galleryUrls: const [
      'assets/images/places/bizerte_activity_27.jpg',
      'assets/images/places/bizerte_activity_7.jpg',
    ],
    address: 'Vieux Port de Bizerte',
    latitude: 37.2720,
    longitude: 9.8765,
    priceMin: 70,
    priceMax: 140,
    rating: 4.4,
    recommendationScore: 90,
    tags: ['Sea', 'Adventure', 'Photography'],
    openingHours: '08:30 - 17:30',
  ),
  _place(
    id: '31000000-0000-0000-0000-000000000012',
    governorateId: bizerteGovernorateId,
    categoryId: _categoryArtisan,
    type: PlaceType.artisan,
    name: 'Qsiba Makers House',
    description:
        'A small-format craft stop highlighting local objects, heritage textures, and handmade detail in the historic core.',
    shortDescription:
        'Artisan address in the old quarter for handcrafted local detail.',
    imageUrl: 'assets/images/places/bizerte_artisan_5.jpg',
    galleryUrls: const [
      'assets/images/places/bizerte_artisan_5.jpg',
      'assets/images/places/bizerte_artisan_25.jpg',
    ],
    address: 'Qsiba quarter, Bizerte',
    latitude: 37.2735,
    longitude: 9.8725,
    priceMin: 30,
    priceMax: 95,
    rating: 4.2,
    recommendationScore: 87,
    isFamilyFriendly: true,
    tags: ['Artisanat', 'Heritage', 'Photography', 'Family Friendly'],
    openingHours: '10:00 - 18:00',
  ),
  _place(
    id: '31000000-0000-0000-0000-000000000013',
    governorateId: bizerteGovernorateId,
    categoryId: _categoryRestaurant,
    type: PlaceType.restaurant,
    name: 'Ghar El Melh Seafood Table',
    description:
        'A food-first stop designed around seafood, lagoon identity, and relaxed coastal hosting.',
    shortDescription:
        'Regional seafood table that fits sea-and-heritage weekends.',
    imageUrl: 'assets/images/places/bizerte_restaurant_3.jpg',
    galleryUrls: const [
      'assets/images/places/bizerte_restaurant_3.jpg',
      'assets/images/places/bizerte_restaurant_23.jpg',
    ],
    address: 'Ghar El Melh waterfront',
    latitude: 37.1560,
    longitude: 10.1920,
    priceMin: 40,
    priceMax: 90,
    rating: 4.5,
    recommendationScore: 90,
    isFamilyFriendly: true,
    tags: ['Food', 'Sea', 'Family Friendly'],
    openingHours: '12:00 - 22:30',
  ),
  _place(
    id: '32000000-0000-0000-0000-000000000001',
    governorateId: kefGovernorateId,
    categoryId: _categoryAccommodation,
    type: PlaceType.accommodation,
    name: 'Hotel Ramzi',
    description:
        'A practical base for Kasbah visits, highland routes, and short cultural stays in Le Kef.',
    shortDescription:
        'Reliable Le Kef stay for heritage and hiking itineraries.',
    imageUrl: 'assets/images/places/kef_accommodation_1.jpg',
    galleryUrls: const [
      'assets/images/places/kef_accommodation_1.jpg',
      'assets/images/places/kef_accommodation_21.jpg',
    ],
    address: 'Centre-ville du Kef',
    latitude: 36.1790,
    longitude: 8.7060,
    priceMin: 120,
    priceMax: 200,
    rating: 4.1,
    recommendationScore: 85,
    isFamilyFriendly: true,
    tags: ['Heritage', 'Food', 'Family Friendly'],
    openingHours: '24/7',
  ),
  _place(
    id: '32000000-0000-0000-0000-000000000002',
    governorateId: kefGovernorateId,
    categoryId: _categoryAccommodation,
    type: PlaceType.accommodation,
    name: 'Dar Alyssa',
    description:
        'A guesthouse-style stay with strong local character for medina and Kasbah explorations.',
    shortDescription:
        'Character stay suited to Le Kef cultural walks and photography trips.',
    imageUrl: 'assets/images/places/kef_accommodation_2.jpg',
    galleryUrls: const [
      'assets/images/places/kef_accommodation_2.jpg',
      'assets/images/places/kef_accommodation_22.jpg',
    ],
    address: 'Historic Le Kef',
    latitude: 36.1760,
    longitude: 8.7040,
    priceMin: 145,
    priceMax: 240,
    rating: 4.5,
    recommendationScore: 92,
    tags: ['Heritage', 'Photography', 'Food'],
    openingHours: '24/7',
  ),
  _place(
    id: '32000000-0000-0000-0000-000000000003',
    governorateId: kefGovernorateId,
    categoryId: _categoryAccommodation,
    type: PlaceType.accommodation,
    name: 'Dar Chennoufi',
    description:
        'A quiet highland address for trekking weekends, local immersion, and eco-minded escapes.',
    shortDescription:
        'Calm local stay for hiking, landscape photography, and slow travel.',
    imageUrl: 'assets/images/places/kef_accommodation_21.jpg',
    galleryUrls: const [
      'assets/images/places/kef_accommodation_21.jpg',
      'assets/images/places/kef_accommodation_22.jpg',
    ],
    address: 'Highlands near Le Kef',
    latitude: 36.2050,
    longitude: 8.6500,
    priceMin: 110,
    priceMax: 180,
    rating: 4.4,
    recommendationScore: 89,
    isFamilyFriendly: true,
    tags: ['Nature', 'Photography', 'Family Friendly'],
    openingHours: '24/7',
  ),
  _place(
    id: '32000000-0000-0000-0000-000000000004',
    governorateId: kefGovernorateId,
    categoryId: _categoryMuseum,
    type: PlaceType.museum,
    name: 'Kasbah du Kef',
    description:
        'A core storytelling anchor for the region, combining architecture, history, and cultural event energy.',
    shortDescription: 'Signature Kasbah visit for Le Kef heritage routes.',
    imageUrl: 'assets/images/places/kef_museum_9.jpg',
    galleryUrls: const [
      'assets/images/places/kef_museum_9.jpg',
      'assets/images/places/kef_museum_29.jpg',
    ],
    address: 'Kasbah du Kef',
    latitude: 36.1805,
    longitude: 8.7055,
    priceMin: 25,
    priceMax: 55,
    rating: 4.7,
    recommendationScore: 97,
    isFamilyFriendly: true,
    tags: ['Heritage', 'Photography', 'Family Friendly'],
    openingHours: '09:00 - 18:00',
  ),
  _place(
    id: '32000000-0000-0000-0000-000000000005',
    governorateId: kefGovernorateId,
    categoryId: _categoryMuseum,
    type: PlaceType.museum,
    name: 'Medina and Traditions Museum Walk',
    description:
        'A combined cultural route through the medina and the Museum of Arts and Popular Traditions.',
    shortDescription:
        'Le Kef cultural circuit joining medina heritage, crafts, and oral history.',
    imageUrl: 'assets/images/places/kef_museum_29.jpg',
    galleryUrls: const [
      'assets/images/places/kef_museum_29.jpg',
      'assets/images/places/kef_museum_9.jpg',
    ],
    address: 'Medina du Kef',
    latitude: 36.1785,
    longitude: 8.7030,
    priceMin: 30,
    priceMax: 70,
    rating: 4.4,
    recommendationScore: 91,
    isFamilyFriendly: true,
    tags: ['Heritage', 'Artisanat', 'Food', 'Family Friendly'],
    openingHours: '09:00 - 17:30',
  ),
  _place(
    id: '32000000-0000-0000-0000-000000000006',
    governorateId: kefGovernorateId,
    categoryId: _categoryNatureSpot,
    type: PlaceType.natureSpot,
    name: 'Table de Jugurtha Panorama',
    description:
        'A dramatic highland landmark with strong hiking appeal, broad views, and serious photography value.',
    shortDescription:
        'Essential outdoor heritage landmark for Le Kef hiking programs.',
    imageUrl: 'assets/images/places/kef_naturespot_11.jpg',
    galleryUrls: const [
      'assets/images/places/kef_naturespot_11.jpg',
      'assets/images/places/kef_naturespot_31.jpg',
    ],
    address: 'Table de Jugurtha',
    latitude: 35.8880,
    longitude: 8.5520,
    priceMin: 35,
    priceMax: 75,
    rating: 4.8,
    recommendationScore: 98,
    tags: ['Nature', 'Adventure', 'Photography'],
    openingHours: '08:00 - 18:00',
  ),
  _place(
    id: '32000000-0000-0000-0000-000000000007',
    governorateId: kefGovernorateId,
    categoryId: _categoryNatureSpot,
    type: PlaceType.natureSpot,
    name: 'Highlands Eco Camp',
    description:
        'A softer mountain-edge base for camping, observation, and slower outdoor immersion around Le Kef.',
    shortDescription:
        'Eco camp atmosphere with views, fresh air, and local guide support.',
    imageUrl: 'assets/images/places/kef_naturespot_31.jpg',
    galleryUrls: const [
      'assets/images/places/kef_naturespot_31.jpg',
      'assets/images/places/kef_naturespot_11.jpg',
    ],
    address: 'High plateaus near Le Kef',
    latitude: 36.2300,
    longitude: 8.6200,
    priceMin: 60,
    priceMax: 120,
    rating: 4.3,
    recommendationScore: 88,
    isFamilyFriendly: true,
    tags: ['Nature', 'Horse Riding', 'Photography', 'Family Friendly'],
    openingHours: '08:00 - 19:00',
  ),
  _place(
    id: '32000000-0000-0000-0000-000000000008',
    governorateId: kefGovernorateId,
    categoryId: _categoryActivity,
    type: PlaceType.activity,
    name: 'Table de Jugurtha Hiking Day',
    description:
        'A strong outdoor seller for Le Kef combining ascent, landscape reading, and heritage framing.',
    shortDescription:
        'Guided hiking day focused on Table de Jugurtha and highland scenery.',
    imageUrl: 'assets/images/places/kef_activity_7.jpg',
    galleryUrls: const [
      'assets/images/places/kef_activity_7.jpg',
      'assets/images/places/kef_activity_27.jpg',
    ],
    address: 'Departure from Le Kef to Table de Jugurtha',
    latitude: 35.8900,
    longitude: 8.5540,
    priceMin: 90,
    priceMax: 170,
    rating: 4.8,
    recommendationScore: 97,
    tags: ['Adventure', 'Nature', 'Photography'],
    openingHours: '07:30 - 17:00',
  ),
  _place(
    id: '32000000-0000-0000-0000-000000000009',
    governorateId: kefGovernorateId,
    categoryId: _categoryActivity,
    type: PlaceType.activity,
    name: 'Kasbah and Medina Cultural Walk',
    description:
        'A compact cultural program built around the Kasbah, medina stories, and regional identity.',
    shortDescription:
        'Walking format for travelers who want Le Kef'
        's heritage core in one route.',
    imageUrl: 'assets/images/places/kef_activity_28.jpg',
    galleryUrls: const [
      'assets/images/places/kef_activity_28.jpg',
      'assets/images/places/kef_activity_8.jpg',
    ],
    address: 'Historic center of Le Kef',
    latitude: 36.1790,
    longitude: 8.7045,
    priceMin: 55,
    priceMax: 110,
    rating: 4.5,
    recommendationScore: 93,
    isFamilyFriendly: true,
    tags: ['Heritage', 'Food', 'Photography', 'Family Friendly'],
    openingHours: '09:30 - 17:30',
  ),
  _place(
    id: '32000000-0000-0000-0000-000000000010',
    governorateId: kefGovernorateId,
    categoryId: _categoryActivity,
    type: PlaceType.activity,
    name: 'Local Food and Artisan Weekend',
    description:
        'A regional program focused on local flavors, maker encounters, and slower cultural immersion.',
    shortDescription:
        'Food-and-craft weekend with strong local immersion in Le Kef.',
    imageUrl: 'assets/images/places/kef_activity_8.jpg',
    galleryUrls: const [
      'assets/images/places/kef_activity_8.jpg',
      'assets/images/places/kef_activity_27.jpg',
    ],
    address: 'Le Kef medina and nearby villages',
    latitude: 36.1820,
    longitude: 8.7090,
    priceMin: 100,
    priceMax: 195,
    rating: 4.6,
    recommendationScore: 94,
    isFamilyFriendly: true,
    tags: ['Food', 'Artisanat', 'Heritage', 'Family Friendly'],
    openingHours: '10:00 - 19:00',
  ),
  _place(
    id: '32000000-0000-0000-0000-000000000011',
    governorateId: kefGovernorateId,
    categoryId: _categoryActivity,
    type: PlaceType.activity,
    name: 'Highlands Horseback Trail',
    description:
        'A guided ride on the high plateaus for travelers who want landscape access beyond the urban core.',
    shortDescription:
        'Horseback route with open views and a strong highland mood.',
    imageUrl: 'assets/images/places/kef_activity_27.jpg',
    galleryUrls: const [
      'assets/images/places/kef_activity_27.jpg',
      'assets/images/places/kef_activity_7.jpg',
    ],
    address: 'Plateau trails outside Le Kef',
    latitude: 36.2200,
    longitude: 8.6400,
    priceMin: 85,
    priceMax: 150,
    rating: 4.4,
    recommendationScore: 90,
    tags: ['Horse Riding', 'Nature', 'Adventure', 'Photography'],
    openingHours: '08:00 - 17:00',
  ),
  _place(
    id: '32000000-0000-0000-0000-000000000012',
    governorateId: kefGovernorateId,
    categoryId: _categoryArtisan,
    type: PlaceType.artisan,
    name: 'Kef Crafts Courtyard',
    description:
        'A curated maker stop that supports the region'
        's craft identity and adds local texture to cultural routes.',
    shortDescription:
        'Handmade local craft stop to pair with food and heritage programs.',
    imageUrl: 'assets/images/places/kef_artisan_5.jpg',
    galleryUrls: const [
      'assets/images/places/kef_artisan_5.jpg',
      'assets/images/places/kef_artisan_25.jpg',
    ],
    address: 'Medina artisan quarter, Le Kef',
    latitude: 36.1770,
    longitude: 8.7048,
    priceMin: 25,
    priceMax: 80,
    rating: 4.3,
    recommendationScore: 88,
    isFamilyFriendly: true,
    tags: ['Artisanat', 'Heritage', 'Family Friendly'],
    openingHours: '10:00 - 18:00',
  ),
  _place(
    id: '32000000-0000-0000-0000-000000000013',
    governorateId: kefGovernorateId,
    categoryId: _categoryRestaurant,
    type: PlaceType.restaurant,
    name: 'Highlands Regional Table',
    description:
        'A regional table centered on northwest flavors and slow shared meals after cultural visits or hikes.',
    shortDescription:
        'Food-first stop for regional dishes and local hospitality.',
    imageUrl: 'assets/images/places/kef_restaurant_3.jpg',
    galleryUrls: const [
      'assets/images/places/kef_restaurant_3.jpg',
      'assets/images/places/kef_restaurant_23.jpg',
    ],
    address: 'Le Kef center',
    latitude: 36.1810,
    longitude: 8.7065,
    priceMin: 35,
    priceMax: 75,
    rating: 4.4,
    recommendationScore: 89,
    isFamilyFriendly: true,
    tags: ['Food', 'Family Friendly'],
    openingHours: '12:00 - 22:00',
  ),
  _place(
    id: '33000000-0000-0000-0000-000000000001',
    governorateId: tozeurGovernorateId,
    categoryId: _categoryAccommodation,
    type: PlaceType.accommodation,
    name: 'The Mora Sahara Tozeur',
    description:
        'A premium desert-edge stay designed for comfort, spa time, and elevated multi-day Tozeur programs.',
    shortDescription:
        'Premium oasis resort for desert, wellness, and cinematic Tozeur stays.',
    imageUrl: 'assets/images/places/tozeur_accommodation_1.jpg',
    galleryUrls: const [
      'assets/images/places/tozeur_accommodation_1.jpg',
      'assets/images/places/tozeur_accommodation_21.jpg',
    ],
    address: 'Tourist zone, Tozeur',
    latitude: 33.9300,
    longitude: 8.1240,
    priceMin: 320,
    priceMax: 520,
    rating: 4.7,
    recommendationScore: 97,
    isFamilyFriendly: true,
    tags: ['Desert', 'Wellness', 'Family Friendly'],
    openingHours: '24/7',
  ),
  _place(
    id: '33000000-0000-0000-0000-000000000002',
    governorateId: tozeurGovernorateId,
    categoryId: _categoryAccommodation,
    type: PlaceType.accommodation,
    name: 'Dar Saida Beya',
    description:
        'A character stay that leans into medina atmosphere, architecture, and intimate cultural comfort.',
    shortDescription: 'Refined stay for oasis and medina cultural escapes.',
    imageUrl: 'assets/images/places/tozeur_accommodation_2.jpg',
    galleryUrls: const [
      'assets/images/places/tozeur_accommodation_2.jpg',
      'assets/images/places/tozeur_accommodation_22.jpg',
    ],
    address: 'Medina of Tozeur',
    latitude: 33.9205,
    longitude: 8.1320,
    priceMin: 230,
    priceMax: 360,
    rating: 4.6,
    recommendationScore: 94,
    tags: ['Heritage', 'Wellness', 'Photography'],
    openingHours: '24/7',
  ),
  _place(
    id: '33000000-0000-0000-0000-000000000003',
    governorateId: tozeurGovernorateId,
    categoryId: _categoryAccommodation,
    type: PlaceType.accommodation,
    name: 'Palm Beach Palace Tozeur',
    description:
        'A larger-format resort for family-friendly desert programs with wellness and pool downtime built in.',
    shortDescription:
        'Large Tozeur resort for families and comfort-led desert stays.',
    imageUrl: 'assets/images/places/tozeur_accommodation_21.jpg',
    galleryUrls: const [
      'assets/images/places/tozeur_accommodation_21.jpg',
      'assets/images/places/tozeur_accommodation_22.jpg',
    ],
    address: 'Tourist road, Tozeur',
    latitude: 33.9255,
    longitude: 8.1220,
    priceMin: 210,
    priceMax: 340,
    rating: 4.3,
    recommendationScore: 90,
    isFamilyFriendly: true,
    tags: ['Desert', 'Wellness', 'Family Friendly'],
    openingHours: '24/7',
  ),
  _place(
    id: '33000000-0000-0000-0000-000000000004',
    governorateId: tozeurGovernorateId,
    categoryId: _categoryNatureSpot,
    type: PlaceType.natureSpot,
    name: 'Chott El Jerid Sunrise Stop',
    description:
        'A high-value desert panorama for sunrise, wide horizon photography, and classic southern storytelling.',
    shortDescription:
        'Essential Chott El Jerid stop for desert light and photography.',
    imageUrl: 'assets/images/places/tozeur_naturespot_11.jpg',
    galleryUrls: const [
      'assets/images/places/tozeur_naturespot_11.jpg',
      'assets/images/places/tozeur_naturespot_31.jpg',
    ],
    address: 'Chott El Jerid, Tozeur',
    latitude: 33.7200,
    longitude: 8.4300,
    priceMin: 30,
    priceMax: 65,
    rating: 4.8,
    recommendationScore: 98,
    isFamilyFriendly: true,
    tags: ['Desert', 'Photography', 'Family Friendly'],
    openingHours: '06:00 - 19:00',
  ),
  _place(
    id: '33000000-0000-0000-0000-000000000005',
    governorateId: tozeurGovernorateId,
    categoryId: _categoryNatureSpot,
    type: PlaceType.natureSpot,
    name: 'Chebika Oasis Walk',
    description:
        'A palm-and-rock contrast route that balances oasis greenery, canyon texture, and soft exploration.',
    shortDescription:
        'Oasis walk with strong scenery and photo appeal near Tozeur.',
    imageUrl: 'assets/images/places/tozeur_naturespot_31.jpg',
    galleryUrls: const [
      'assets/images/places/tozeur_naturespot_31.jpg',
      'assets/images/places/tozeur_naturespot_11.jpg',
    ],
    address: 'Chebika oasis',
    latitude: 34.3190,
    longitude: 7.9350,
    priceMin: 40,
    priceMax: 85,
    rating: 4.7,
    recommendationScore: 96,
    isFamilyFriendly: true,
    tags: ['Nature', 'Desert', 'Photography', 'Family Friendly'],
    openingHours: '08:00 - 18:00',
  ),
  _place(
    id: '33000000-0000-0000-0000-000000000006',
    governorateId: tozeurGovernorateId,
    categoryId: _categoryNatureSpot,
    type: PlaceType.natureSpot,
    name: 'Tamerza Canyon',
    description:
        'A dramatic canyon environment with strong adventure framing and one of the region'
        's most marketable landscapes.',
    shortDescription:
        'Canyon stop for desert adventure, scenery, and active discovery.',
    imageUrl: 'assets/images/places/tozeur_naturespot_11.jpg',
    galleryUrls: const [
      'assets/images/places/tozeur_naturespot_11.jpg',
      'assets/images/places/tozeur_naturespot_31.jpg',
    ],
    address: 'Tamerza canyon',
    latitude: 34.3920,
    longitude: 7.9440,
    priceMin: 45,
    priceMax: 95,
    rating: 4.8,
    recommendationScore: 97,
    tags: ['Desert', 'Adventure', 'Photography'],
    openingHours: '08:00 - 18:00',
  ),
  _place(
    id: '33000000-0000-0000-0000-000000000007',
    governorateId: tozeurGovernorateId,
    categoryId: _categoryMuseum,
    type: PlaceType.museum,
    name: 'Tozeur Medina Brick Walk',
    description:
        'A medina route focused on the city'
        's brick architecture, quiet lanes, and local identity.',
    shortDescription:
        'Medina walk highlighting Tozeur'
        's architecture and urban heritage.',
    imageUrl: 'assets/images/places/tozeur_museum_9.jpg',
    galleryUrls: const [
      'assets/images/places/tozeur_museum_9.jpg',
      'assets/images/places/tozeur_museum_29.jpg',
    ],
    address: 'Old Tozeur medina',
    latitude: 33.9180,
    longitude: 8.1300,
    priceMin: 35,
    priceMax: 80,
    rating: 4.5,
    recommendationScore: 91,
    isFamilyFriendly: true,
    tags: ['Heritage', 'Photography', 'Artisanat', 'Family Friendly'],
    openingHours: '09:00 - 18:00',
  ),
  _place(
    id: '33000000-0000-0000-0000-000000000008',
    governorateId: tozeurGovernorateId,
    categoryId: _categoryActivity,
    type: PlaceType.activity,
    name: 'Star Wars Filming Locations Tour',
    description:
        'A cinematic excursion covering Ong Jemel and Mos Espa style landscapes with strong visual storytelling.',
    shortDescription:
        'Signature cinema-themed desert excursion around Ong Jemel and Mos Espa.',
    imageUrl: 'assets/images/places/tozeur_activity_7.jpg',
    galleryUrls: const [
      'assets/images/places/tozeur_activity_7.jpg',
      'assets/images/places/tozeur_activity_27.jpg',
    ],
    address: 'Departure from Tozeur to Ong Jemel',
    latitude: 33.8600,
    longitude: 7.8900,
    priceMin: 150,
    priceMax: 280,
    rating: 4.8,
    recommendationScore: 99,
    isFamilyFriendly: true,
    tags: ['Desert', 'Adventure', 'Photography', 'Family Friendly'],
    openingHours: '08:00 - 18:00',
  ),
  _place(
    id: '33000000-0000-0000-0000-000000000009',
    governorateId: tozeurGovernorateId,
    categoryId: _categoryActivity,
    type: PlaceType.activity,
    name: 'Chebika-Tamerza-Mides One-Day Escape',
    description:
        'A dense desert-and-oasis circuit built around the three classic mountain oasis highlights.',
    shortDescription:
        'Best-selling one-day route across Chebika, Tamerza, and Mides.',
    imageUrl: 'assets/images/places/tozeur_activity_28.jpg',
    galleryUrls: const [
      'assets/images/places/tozeur_activity_28.jpg',
      'assets/images/places/tozeur_activity_8.jpg',
    ],
    address: 'Mountain oasis circuit from Tozeur',
    latitude: 34.3200,
    longitude: 7.9400,
    priceMin: 170,
    priceMax: 310,
    rating: 4.9,
    recommendationScore: 100,
    isFamilyFriendly: true,
    tags: ['Desert', 'Adventure', 'Nature', 'Photography', 'Family Friendly'],
    openingHours: '08:00 - 18:30',
  ),
  _place(
    id: '33000000-0000-0000-0000-000000000010',
    governorateId: tozeurGovernorateId,
    categoryId: _categoryActivity,
    type: PlaceType.activity,
    name: 'Romantic Desert Sunset Experience',
    description:
        'A slower golden-hour desert program pairing soft adventure with sunset staging and comfort touches.',
    shortDescription:
        'Sunset experience for couples and travelers seeking a softer desert format.',
    imageUrl: 'assets/images/places/tozeur_activity_8.jpg',
    galleryUrls: const [
      'assets/images/places/tozeur_activity_8.jpg',
      'assets/images/places/tozeur_activity_27.jpg',
    ],
    address: 'Sunset camp outside Tozeur',
    latitude: 33.8600,
    longitude: 8.0300,
    priceMin: 140,
    priceMax: 260,
    rating: 4.7,
    recommendationScore: 95,
    tags: ['Desert', 'Wellness', 'Photography'],
    openingHours: '16:00 - 21:00',
  ),
  _place(
    id: '33000000-0000-0000-0000-000000000011',
    governorateId: tozeurGovernorateId,
    categoryId: _categoryActivity,
    type: PlaceType.activity,
    name: 'Horseback Oasis Discovery',
    description:
        'A horseback route that connects oasis calm, local agriculture scenery, and active discovery.',
    shortDescription:
        'Horse riding experience through oasis landscapes and palm-grove edges.',
    imageUrl: 'assets/images/places/tozeur_activity_27.jpg',
    galleryUrls: const [
      'assets/images/places/tozeur_activity_27.jpg',
      'assets/images/places/tozeur_activity_7.jpg',
    ],
    address: 'Palm groves of Tozeur',
    latitude: 33.9250,
    longitude: 8.1450,
    priceMin: 110,
    priceMax: 195,
    rating: 4.6,
    recommendationScore: 93,
    tags: ['Horse Riding', 'Nature', 'Photography'],
    openingHours: '08:00 - 17:00',
  ),
  _place(
    id: '33000000-0000-0000-0000-000000000012',
    governorateId: tozeurGovernorateId,
    categoryId: _categoryArtisan,
    type: PlaceType.artisan,
    name: 'Oasis Palm Weaving House',
    description:
        'A local craft address that brings palm-based know-how and oasis material culture into the route.',
    shortDescription:
        'Craft visit focused on palm weaving and oasis artisan detail.',
    imageUrl: 'assets/images/places/tozeur_artisan_5.jpg',
    galleryUrls: const [
      'assets/images/places/tozeur_artisan_5.jpg',
      'assets/images/places/tozeur_artisan_25.jpg',
    ],
    address: 'Craft quarter, Tozeur',
    latitude: 33.9190,
    longitude: 8.1340,
    priceMin: 35,
    priceMax: 90,
    rating: 4.4,
    recommendationScore: 90,
    isFamilyFriendly: true,
    tags: ['Artisanat', 'Heritage', 'Family Friendly'],
    openingHours: '10:00 - 18:00',
  ),
  _place(
    id: '33000000-0000-0000-0000-000000000013',
    governorateId: tozeurGovernorateId,
    categoryId: _categoryRestaurant,
    type: PlaceType.restaurant,
    name: 'Date and Hammam Retreat Table',
    description:
        'A hybrid food-and-wellness stop that fits slower Tozeur stays and comfort-led desert programs.',
    shortDescription:
        'Food and wellness stop that pairs well with spa or medina itineraries.',
    imageUrl: 'assets/images/places/tozeur_restaurant_3.jpg',
    galleryUrls: const [
      'assets/images/places/tozeur_restaurant_3.jpg',
      'assets/images/places/tozeur_restaurant_23.jpg',
    ],
    address: 'Tozeur oasis district',
    latitude: 33.9240,
    longitude: 8.1380,
    priceMin: 45,
    priceMax: 110,
    rating: 4.5,
    recommendationScore: 91,
    isFamilyFriendly: true,
    tags: ['Food', 'Wellness', 'Family Friendly'],
    openingHours: '12:00 - 22:00',
  ),
  _place(
    id: '33000000-0000-0000-0000-000000000014',
    governorateId: tozeurGovernorateId,
    categoryId: _categoryTransport,
    type: PlaceType.transport,
    name: 'Ong Jemel 4x4 Transfer',
    description:
        'Certified driver support for desert loops when the route requires managed 4x4 access.',
    shortDescription:
        'Partner-led 4x4 transfer for structured desert excursions.',
    imageUrl: 'assets/images/places/tozeur_transport_10.jpg',
    galleryUrls: const [
      'assets/images/places/tozeur_transport_10.jpg',
      'assets/images/places/tozeur_transport_30.jpg',
    ],
    address: 'Tozeur departure point',
    latitude: 33.9185,
    longitude: 8.1260,
    priceMin: 160,
    priceMax: 260,
    rating: 4.5,
    recommendationScore: 92,
    tags: ['Desert', 'Adventure'],
    openingHours: '07:00 - 18:00',
  ),
];

Place _place({
  required String id,
  required String governorateId,
  required String categoryId,
  required PlaceType type,
  required String name,
  required String description,
  required String shortDescription,
  required String imageUrl,
  required List<String> galleryUrls,
  required String address,
  required double latitude,
  required double longitude,
  required double priceMin,
  required double priceMax,
  required double rating,
  required double recommendationScore,
  bool isFamilyFriendly = false,
  bool isLocalPartner = true,
  List<String> tags = const <String>[],
  String? openingHours,
}) {
  return Place(
    id: id,
    governorateId: governorateId,
    categoryId: categoryId,
    type: type,
    name: name,
    description: description,
    shortDescription: shortDescription,
    imageUrl: imageUrl,
    galleryUrls: galleryUrls,
    address: address,
    latitude: latitude,
    longitude: longitude,
    priceMin: priceMin,
    priceMax: priceMax,
    rating: rating,
    recommendationScore: recommendationScore,
    isFamilyFriendly: isFamilyFriendly,
    isLocalPartner: isLocalPartner,
    isActive: true,
    tags: tags,
    openingHours: openingHours,
  );
}
