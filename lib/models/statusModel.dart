class Status {
  String country;
  String lastUpdate;
  int cases;
  int deaths;
  int recovered;

  Status({
    this.country,
    this.lastUpdate,
    this.cases,
    this.deaths,
    this.recovered,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      country: json['country'],
      lastUpdate: json['lastUpdate'],
      cases: json['cases'],
      deaths: json['deaths'],
      recovered: json['recovered'],
    );
  }
}
