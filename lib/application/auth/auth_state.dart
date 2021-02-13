abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthLoaded extends AuthState {
  final String token;
  AuthLoaded(this.token);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
