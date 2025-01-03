import 'package:assesment/model/city.dart';
import 'package:assesment/model/province.dart';

List<Province> provincesItem = [
  Province(id: 1, name: 'Aceh', cities: [
    City(id: 1, name: 'Banda Aceh'),
    City(id: 2, name: 'Sabang'),
  ]),
  Province(id: 2, name: 'Jawa Barat', cities: [
    City(id: 1, name: 'Bandung'),
    City(id: 2, name: 'Bekasi'),
    City(id: 3, name: 'Depok'),
  ]),
  Province(id: 3, name: 'Jawa Tengah', cities: [
    City(id: 1, name: 'Semarang'),
    City(id: 2, name: 'Surakarta'),
  ]),
  Province(id: 4, name: 'Jawa Timur', cities: [
    City(id: 1, name: 'Surabaya'),
    City(id: 2, name: 'Malang'),
  ]),
  Province(id: 5, name: 'Kepulauan Riau', cities: [
    City(id: 1, name: 'Tanjung'),
    City(id: 2, name: 'Tanjung Pinang'),
  ]),
];
