class Country {
  String name;
  String alpha2;
  String alpha3;
  String numeric;
  double latitude;
  double longitude;

  Country({
    this.name,
    this.alpha2,
    this.alpha3,
    this.numeric,
    this.latitude,
    this.longitude,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      alpha2: json['alpha2'],
      alpha3: json['alpha3'],
      numeric: json['numeric'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
