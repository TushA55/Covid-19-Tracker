import 'package:flutter/cupertino.dart';
import '../services/services.dart';

class DataProvider with ChangeNotifier {
  Map<String, dynamic> _countriesMap = {};

  Stream<List<dynamic>> getStatus() async* {
    var _countriesList = await getCountriesApi();
    _countriesList.forEach((element) {
      _countriesMap[element.alpha2] =
          element.name.split(" ").length > 1 ? element.alpha3 : element.name;
    });
    List<dynamic> _data = await getStatusApi();
    yield _data;
  }

  Map<String, dynamic> get countriesMap => _countriesMap;
}
