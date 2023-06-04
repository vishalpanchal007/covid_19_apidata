import 'dart:convert';

import 'package:covid_19_corona_cases/filecovid.dart';
import 'package:http/http.dart'as http;
class COVIDAPI {
  static String baseUrl = "https://disease.sh/v3/covid-19";

  Future<GlobalData> getGlobalData() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return GlobalData.fromjson(data);
    } else {
      throw Exception('Failed to load global data');
    }
  }
  
  Future<List<CountryData>> getCountryData()async{
    final response = await http.get(Uri.parse('$baseUrl/countries'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => CountryData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load global data');
    }
  }
}