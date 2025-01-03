import 'package:assesment/component/list.dart';
import 'package:assesment/model/city.dart';
import 'package:assesment/model/province.dart';
import 'package:assesment/viewmodel/input_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_searchable_dropdown/flutter_searchable_dropdown.dart';

Widget inputField(TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: 'Masukkan nama anda',
      prefixIcon: Icon(Icons.person),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    style: TextStyle(fontSize: 16),
  );
}

Widget provinceDropdown(InputViewModel viewModel) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(12),
    ),
    child: SearchableDropdown.single(
      items: provincesItem.map((Province province) {
        return DropdownMenuItem<Province>(
          value: province,
          child: Text(province.name ?? ""),
        );
      }).toList(),
      value: viewModel.selectedProvince ?? provincesItem.first,
      hint: Text("Pilih Provinsi"),
      searchHint: Text("Cari Provinsi"),
      onChanged: (Province? newValue) {
        viewModel.selectProvince(newValue);
      },
      isExpanded: true,
      displayClearIcon: false,
    ),
  );
}

Widget cityDropdown(InputViewModel viewModel) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(12),
    ),
    child: SearchableDropdown.single(
      items: viewModel.selectedProvince!.cities.map((City city) {
        return DropdownMenuItem<City>(
          value: city,
          child: Text(city.name),
        );
      }).toList(),
      value: viewModel.selectedCity,
      hint: Text("Pilih Kota"),
      searchHint: Text("Cari Kota"),
      onChanged: (City? newValue) {
        viewModel.selectCity(newValue);
      },
      isExpanded: true,
      displayClearIcon: false,
    ),
  );
}
