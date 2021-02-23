import 'package:lovecity_app/domain/province/province_model.dart';

abstract class IProvinceApi {
  Future<List<ProvinceModel>> getAll();
  Future<List<ProvinceModel>> getLimitProvincies(String limit);
  Future<List<ProvinceModel>> getOrderBy(String orderBy, String equalTo);
}
