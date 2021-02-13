import 'package:lovecity_app/infrastructure/cache/i_local_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStore implements ILocalStore {
  final SharedPreferences sharedPreferences;

  LocalStore(this.sharedPreferences);

  @override
  Future save(SharedKeys key, String value) async {
    return await sharedPreferences.setString(key.toString(), value);
  }

  @override
  Future delete(SharedKeys key, String value) async {
    return await sharedPreferences.remove(key.toString());
  }

  @override
  Future getvalue(SharedKeys key) async {
    return sharedPreferences.getString(key.toString());
  }
}

enum SharedKeys { TOKEN, USERID }
