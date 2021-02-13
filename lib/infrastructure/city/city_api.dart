import 'dart:convert';

import 'package:lovecity_app/domain/city/city_model.dart';
import 'package:lovecity_app/infrastructure/city/i_city_api.dart';
import 'package:lovecity_app/infrastructure/core/http_result.dart';
import 'package:lovecity_app/infrastructure/core/i_http_client.dart';

class CityApi implements ICityApi {
  final String _baseUrl;
  final IHttpClient _httpClient;

  CityApi(this._baseUrl, this._httpClient);

  @override
  Future<List<CityModel>> getAll() async {
    final endpoint = _baseUrl + 'cities.json';
    return await _getListCity(endpoint);
  }

  @override
  Future<List<CityModel>> getLimitCities(String number) async {
    final endpoint = _baseUrl + 'cities.json?limitToLast=$number';
    return await _getListCity(endpoint);
  }

  Future<List<CityModel>> _getListCity(String endpoint) async {
    final response = await _httpClient.get(endpoint);
    final jsonModel = jsonDecode(response.data);
    if (response.status == Status.failure) {
      return jsonModel;
    }
    if (jsonModel is Map) {
      if (jsonModel.length >= 1) {
        List<CityModel> list = [];
        jsonModel.forEach((key, value) {
          CityModel cityModel = CityModel.fromJson(value);
          cityModel.id = key;
          list.add(cityModel);
        });
        return list;
      }
    }
    return jsonModel;
  }
}
