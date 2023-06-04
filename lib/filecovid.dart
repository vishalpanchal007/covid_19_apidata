class GlobalData {
  final int cases;
  final int deaths;
  final int recovered;
  final int active;

  GlobalData({
    required this.cases,
    required this.deaths,
    required this.recovered,
    required this.active
});

  factory GlobalData.fromjson(Map<String,dynamic>json){
    return GlobalData(
        cases:  json["cases"],
        deaths: json["deaths"],
        recovered: json["recovered"],
        active: json["active"]);
  }
}


class CountryData{
  final String country;
  final int cases;
  final int deaths;
  final int recovered;
  final int active;

  CountryData({
    required this.country,
    required this.cases,
    required this.deaths,
    required this.recovered,
    required this.active
});
   factory CountryData.fromJson(Map<String, dynamic>json){
     return CountryData(
     country: json["country"],
     cases: json["cases"],
     deaths: json["deaths"],
     recovered: json["recovered"],
     active: json["active"]);

  }
}