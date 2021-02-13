import 'dart:convert';

import 'package:lovecity_app/domain/auth/user_error_model.dart';
import 'package:lovecity_app/domain/auth/user_model.dart';
import 'package:async/async.dart';
import 'package:lovecity_app/domain/auth/user_success_model.dart';
import 'package:lovecity_app/infrastructure/auth/i_auth_api.dart';
import 'package:lovecity_app/infrastructure/core/http_result.dart';
import 'package:lovecity_app/infrastructure/core/i_http_client.dart';

class AuthApi implements IAuthApi {
  final IHttpClient httpClient;
  final String baseUrl;

  AuthApi(this.httpClient, this.baseUrl);

  @override
  Future<Result<String>> signIn(UserModel user) async {
    final endpoint = baseUrl + 'signInWithPassword?key=APIKEY';
    return await _postUser(endpoint, user);
  }

  @override
  Future<Result<bool>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> signUp(UserModel user) async {
    final endpoint = baseUrl + 'signUp?key=APIKEY';
    return await _postUser(endpoint, user);
  }

  Future<Result<String>> _postUser(String endpoint, UserModel user) async {
    final model = jsonEncode(user.toJson());
    final result = await httpClient.post(endpoint, model);
    if (result.status == Status.failure) {
      final errorModel = jsonDecode(result.data);
      var resultError = UserErrorModel.fromJson(errorModel);
      return Result.error(resultError.error.message);
    }
    final successModel = jsonDecode(result.data);
    final resultSuccess = UserSuccessModel.fromJson(successModel);
    return Result.value(resultSuccess.idToken);
  }
}
