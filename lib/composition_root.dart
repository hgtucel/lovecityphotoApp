import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:lovecity_app/application/auth/auth_cubit.dart';
import 'package:lovecity_app/application/city/city_cubit.dart';
import 'package:lovecity_app/infrastructure/auth/auth_api.dart';
import 'package:lovecity_app/infrastructure/cache/i_local_store.dart';
import 'package:lovecity_app/infrastructure/cache/local_store.dart';
import 'package:lovecity_app/infrastructure/core/http_client.dart';
import 'package:lovecity_app/presentation/pages/auth/auth_page.dart';
import 'package:lovecity_app/presentation/pages/city/city_list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'infrastructure/city/city_api.dart';
import 'infrastructure/core/i_http_client.dart';

class CompositionRoot {
  static SharedPreferences _sharedPreferences;
  static ILocalStore _localStore;
  static Client _client;
  static IHttpClient _httpClient;
  static String _baseUrl;
  static CityApi _cityApi;
  static String _authBaseUrl;
  static AuthApi _authApi;

  static configure() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _localStore = LocalStore(_sharedPreferences);
    _client = Client();
    _httpClient = HttpClient(_client);
    _baseUrl = "https://XXXX.COM/";
    _cityApi = CityApi(_baseUrl, _httpClient);
    _authBaseUrl = "https://identitytoolkit.googleapis.com/v1/accounts:";
    _authApi = AuthApi(_httpClient, _authBaseUrl);
  }

  static Future<Widget> startPage() async {
    final token = await _localStore.getvalue(SharedKeys.TOKEN);
    return token == null ? composeAuthUI() : composeHomeUI();
  }

  static Widget composeHomeUI() {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (BuildContext context) => CityCubit(_cityApi)),
    ], child: CityListPage());
  }

  static Widget composeAuthUI() {
    return BlocProvider(
      create: (BuildContext context) => AuthCubit(_localStore, _authApi),
      child: AuthPage(),
    );
  }
}
