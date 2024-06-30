import 'dart:convert';

import 'package:book_store_apps/data/local/shared_preferences.dart';
import 'package:book_store_apps/ui/home/main_screen.dart';
import 'package:book_store_apps/ui/introduction/register/register_screen.dart';
import 'package:book_store_apps/widgets/alert/m_snackbar.dart';
import 'package:flutter/material.dart';

class LoginScreenProvider extends ChangeNotifier {
  final SharedPreferencesHelper sharedPreferencesHelper;

  LoginScreenProvider(this.sharedPreferencesHelper);

  bool isValidation = true;

  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  bool validation() {
    bool valid = true;

    if (userNameCtrl.text.isEmpty) {
      valid = false;
    }

    if (passwordCtrl.text.isEmpty) {
      valid = false;
    }

    isValidation = valid;
    notifyListeners();

    return valid;
  }

  Future<void> submit(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!validation()) return;

    final authData = sharedPreferencesHelper.userData;

    if (authData.isEmpty) {
      MSnackbar.show('User cannot be found!');
      return;
    }

    List<dynamic> users = jsonDecode(authData);
    for (var element in users) {
      if (element['username'] == userNameCtrl.text && element['password'] == passwordCtrl.text) {
        sharedPreferencesHelper.saveUserLogin(element['userid'] ?? -1);
        Navigator.pushNamedAndRemoveUntil(
            context, MainScreen.routeName, (route) => false);
        return;
      }
    }

    MSnackbar.show('User cannot be found!');
  }

  Future<void> goToRegister(BuildContext context) async {
    Navigator.pushNamed(context, RegisterScreen.routeName);
  }
}
