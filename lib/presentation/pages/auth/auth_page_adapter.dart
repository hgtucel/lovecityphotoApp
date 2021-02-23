import 'package:flutter/material.dart';

abstract class IAuthPageAdapter {
  void authSuccess(BuildContext context);
}

class AuthPageAdapter extends IAuthPageAdapter {
  final Widget Function() onUserAuthenticated;

  AuthPageAdapter(this.onUserAuthenticated);
  @override
  void authSuccess(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => onUserAuthenticated()));
  }
}
