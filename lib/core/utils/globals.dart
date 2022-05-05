import 'dart:convert';

import 'package:flutter/services.dart';

import '../../auth/models/city.dart';
import '../../auth/models/user_model.dart';
import '../resources/assets_manager.dart';
import '../../auth/models/governorate.dart';

List<Governorate> governorates = [];
List<City> cities = [];
late User currentUser;

Future<void> getAllGovernorates() async {
  final String _stringResponse =
      await rootBundle.loadString(AppJson.governorates);
  final _response = jsonDecode(_stringResponse);
  final List<Governorate> _governorates = [];
  for (var gov in _response[2]["data"]) {
    _governorates.add(
      Governorate.fromJson(gov),
    );
  }
  governorates = _governorates;
}

Future<void> getAllCities() async {
  final String _stringResponse = await rootBundle.loadString(AppJson.cities);
  final _response = jsonDecode(_stringResponse);
  final List<City> _cities = [];
  for (var city in _response[2]["data"]) {
    _cities.add(
      City.fromJson(city),
    );
  }
  cities = _cities;
}
