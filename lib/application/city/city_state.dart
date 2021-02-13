import 'package:lovecity_app/domain/city/city_model.dart';

abstract class CityState {
  const CityState();
}

class CityInitial extends CityState {
  const CityInitial();
}

class CityLoading extends CityState {
  const CityLoading();
}

class CityLoaded extends CityState {
  final CityModel city;
  const CityLoaded(this.city);
}

class CitiesLoaded extends CityState {
  final List<CityModel> cities;
  const CitiesLoaded(this.cities);
}

class CityError extends CityState {
  final String message;
  const CityError(this.message);
}
