import 'dart:convert';

import 'package:lovecity_app/domain/province/province_model.dart';
import 'package:lovecity_app/infrastructure/core/http_result.dart';
import 'package:lovecity_app/infrastructure/core/i_http_client.dart';
import 'package:lovecity_app/infrastructure/provience/i_province_api.dart';

class ProvinceApi extends IProvinceApi {
  final String _baseUrl;
  final IHttpClient _httpClient;

  ProvinceApi(this._baseUrl, this._httpClient);

  @override
  Future<List<ProvinceModel>> getAll() async {
    final endpoint = _baseUrl + 'proviencies.json';
    return await _getListProvincies(endpoint);
  }

  @override
  Future<List<ProvinceModel>> getLimitProvincies(String limit) async {
    final endpoint = _baseUrl + 'proviencies.json?limitToFirst=$limit';
    return await _getListProvincies(endpoint);
  }

  Future<List<ProvinceModel>> _getListProvincies(String endpoint) async {
    final response = await _httpClient.get(endpoint);
    final jsonModel = jsonDecode(response.data);
    if (response.status == Status.failure) {
      return jsonModel;
    }
    if (jsonModel is Map) {
      if (jsonModel.length >= 1) {
        List<ProvinceModel> list = [];
        jsonModel.forEach((key, value) {
          ProvinceModel model = ProvinceModel.fromJson(value);
          model.key = key;
          list.add(model);
        });
        return list;
      }
    }
    return jsonModel;
  }

  @override
  Future<List<ProvinceModel>> getOrderBy(String orderBy, String equalTo) async {
    final endpoint =
        _baseUrl + 'proviencies.json?orderBy=\"$orderBy\"&equalTo=\"$equalTo\"';
    return await _getListProvincies(endpoint);
  }
}
