import 'dart:convert';
import 'package:covid_19_tracker/models/countryModel.dart';
import 'package:http/http.dart' as http;

import '../models/statusModel.dart';

// Covid Api Endpoints
const String _statusUrl = 'https://covid19-api.org/api/status';
const String _countriesUrl = 'https://covid19-api.org/api/countries';

Future<List<dynamic>> getStatusApi() async {
  http.Response resp = await http.get(_statusUrl);
  var _jsonData = jsonDecode(resp.body);
  return _jsonData.map((record) => Status.fromJson(record)).toList();
}

Future<List<dynamic>> getCountriesApi() async {
  http.Response resp = await http.get(_countriesUrl);
  var jsonData = jsonDecode(resp.body);
  return jsonData.map((item) => Country.fromJson(item)).toList();
}
