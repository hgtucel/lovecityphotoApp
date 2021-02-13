import 'package:lovecity_app/domain/city/city_model.dart';

abstract class ICityApi {
  Future<List<CityModel>> getAll();
  Future<List<CityModel>> getLimitCities(String number);
}
