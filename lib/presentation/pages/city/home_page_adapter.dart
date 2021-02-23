import 'package:flutter/material.dart';

abstract class IHomePageAdapter {
  void onUserLogout(BuildContext context);
}

class HomePageAdapter implements IHomePageAdapter {
  final Widget Function() onLogout;
  HomePageAdapter(this.onLogout);
  @override
  void onUserLogout(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => onLogout()));
  }
}
