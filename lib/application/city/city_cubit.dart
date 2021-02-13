import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovecity_app/application/city/city_state.dart';
import 'package:lovecity_app/infrastructure/city/i_city_api.dart';

class CityCubit extends Cubit<CityState> {
  final ICityApi _cityApi;

  CityCubit(this._cityApi) : super(CityInitial());

  Future<void> getAll() async {
    emit(CityLoading());
    final cities = await _cityApi.getAll();
    cities != null
        ? emit(CitiesLoaded(cities))
        : emit(CityError("Şehirler bulunamadı."));
  }

  Future<void> getLimitCities(String number) async {
    emit(CityLoading());
    final cities = await _cityApi.getLimitCities(number);
    cities != null
        ? emit(CitiesLoaded(cities))
        : emit(CityError("Şehirler bulunamadı"));
  }
}
