import 'package:lovecity_app/domain/auth/user_success_model.dart';
import 'package:lovecity_app/infrastructure/cache/local_store.dart';

abstract class ILocalStore {
  Future getvalue(SharedKeys key);
  Future delete(SharedKeys key, String value);
  Future save(SharedKeys key, String value);
}
