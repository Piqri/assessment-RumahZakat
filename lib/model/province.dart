import 'package:assesment/model/city.dart';

class Province {
  final int? id;
  final String? name;
  final List<City> cities;

  Province({this.id, this.name, required this.cities});
}
