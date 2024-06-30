import 'package:book_store_apps/data/local/shared_preferences.dart';
import 'package:book_store_apps/ui/home/main_screen.dart';
import 'package:book_store_apps/ui/introduction/login/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreenProvider extends ChangeNotifier {
  final SharedPreferencesHelper sharedPreferencesHelper;

  SplashScreenProvider(this.sharedPreferencesHelper);

  Future<void> checkLogin(BuildContext context) async {
    final int isLogin = sharedPreferencesHelper.savedLogin;

    if(isLogin > 0) {
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.routeName, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.routeName, (route) => false);
    }
  }

  void initialChecking(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      checkLogin(context);
    });
  }
}
