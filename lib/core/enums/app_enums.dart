enum TravelTheme { culinary, nature, heritage, artisan, cycling, adventure }

extension TravelThemeX on TravelTheme {
  String get label => switch (this) {
    TravelTheme.culinary => 'Culinary',
    TravelTheme.nature => 'Nature',
    TravelTheme.heritage => 'Heritage',
    TravelTheme.artisan => 'Artisan',
    TravelTheme.cycling => 'Cycling',
    TravelTheme.adventure => 'Adventure',
  };

  String get storageValue => name;
}

enum TravelStyle { solo, couple, family, friends }

extension TravelStyleX on TravelStyle {
  String get label => switch (this) {
    TravelStyle.solo => 'Solo',
    TravelStyle.couple => 'Couple',
    TravelStyle.family => 'Family',
    TravelStyle.friends => 'Friends',
  };
}

enum ActivityLevel { low, medium, high }

extension ActivityLevelX on ActivityLevel {
  String get label => switch (this) {
    ActivityLevel.low => 'Low',
    ActivityLevel.medium => 'Medium',
    ActivityLevel.high => 'High',
  };
}

enum PlaceType {
  accommodation,
  restaurant,
  artisan,
  activity,
  museum,
  transport,
  natureSpot,
  experience,
}

extension PlaceTypeX on PlaceType {
  String get label => switch (this) {
    PlaceType.accommodation => 'Stay',
    PlaceType.restaurant => 'Restaurant',
    PlaceType.artisan => 'Artisan',
    PlaceType.activity => 'Activity',
    PlaceType.museum => 'Museum',
    PlaceType.transport => 'Transport',
    PlaceType.natureSpot => 'Nature',
    PlaceType.experience => 'Experience',
  };
}

enum BookingStatus { draft, pendingPayment, confirmed, cancelled }

enum PaymentStatus { pending, success, failed, refunded }

enum PaymentMethod { card, wallet, cash }
