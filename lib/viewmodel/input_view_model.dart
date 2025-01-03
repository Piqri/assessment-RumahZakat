import 'package:flutter/material.dart';
import 'package:assesment/model/city.dart';
import 'package:assesment/model/province.dart';

class InputViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  Province? selectedProvince;
  City? selectedCity;

  void selectProvince(Province? province) {
    selectedProvince = province;
    selectedCity = null;
    notifyListeners();
  }

  void selectCity(City? city) {
    selectedCity = city;
    notifyListeners();
  }

  bool isValidInput() {
    return selectedProvince != null && selectedCity != null;
  }

  String getName() {
    return nameController.text;
  }
}
