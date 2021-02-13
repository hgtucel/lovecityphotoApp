import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovecity_app/application/auth/auth_state.dart';
import 'package:lovecity_app/domain/auth/user_error_model.dart';
import 'package:lovecity_app/domain/auth/user_model.dart';
import 'package:lovecity_app/infrastructure/auth/i_auth_api.dart';
import 'package:lovecity_app/infrastructure/cache/i_local_store.dart';
import 'package:lovecity_app/infrastructure/cache/local_store.dart';

class AuthCubit extends Cubit<AuthState> {
  final ILocalStore localStore;
  final IAuthApi _authApi;

  AuthCubit(this.localStore, this._authApi) : super(AuthInitial());

  signIn(UserModel user) async {
    emit(AuthLoading());
    final result = await _authApi.signIn(user);
    if (result.asError != null) {
      emit(AuthError(result.asError.error));
    } else {
      localStore.save(SharedKeys.TOKEN, result.asValue.value);
      emit(AuthLoaded(result.asValue.value));
    }
  }

  signUp(UserModel user) async {
    emit(AuthLoading());
    final result = await _authApi.signUp(user);
    if (result.asError != null) {
      emit(AuthError(result.asError.error));
    } else {
      localStore.save(SharedKeys.TOKEN, result.asValue.value);
      emit(AuthLoaded(result.asValue.value));
    }
  }
}
