import 'package:async/async.dart';
import 'package:lovecity_app/domain/auth/user_model.dart';

abstract class IAuthApi {
  Future<Result<String>> signIn(UserModel user);
  Future<Result<String>> signUp(UserModel user);
  Future<Result<bool>> signOut();
}
