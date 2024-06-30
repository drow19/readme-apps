import 'dart:convert';

import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/data/local/shared_preferences.dart';
import 'package:book_store_apps/models/user_model.dart';
import 'package:book_store_apps/ui/introduction/login/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreenProvider extends ChangeNotifier {
  final SharedPreferencesHelper sharedPreferencesHelper;

  RegisterScreenProvider(this.sharedPreferencesHelper);

  bool isValidation = true;

  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController passConfCtrl = TextEditingController();

  bool validation() {
    bool valid = true;

    if (userNameCtrl.text.isEmpty) {
      valid = false;
    }

    if (passwordCtrl.text.isEmpty) {
      valid = false;
    }

    if (passConfCtrl.text.isEmpty) {
      valid = false;
    }

    if (passwordCtrl.text.isNotEmpty && passConfCtrl.text.isNotEmpty) {
      if (passConfCtrl.text != passwordCtrl.text) {
        valid = false;
      }
    }

    isValidation = valid;
    notifyListeners();

    return valid;
  }

  void clearForm() {
    userNameCtrl.clear();
    passwordCtrl.clear();
    passConfCtrl.clear();

    notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!validation()) {
      return;
    }

    final authData = sharedPreferencesHelper.userData;
    List<UserModel> listAuth = List<UserModel>.empty(growable: true);

    if (authData.isNotEmpty) {
      listAuth = (jsonDecode(authData) as List)
          .map((item) => UserModel.fromJson(item))
          .toList();

      if (listAuth.any((user) => user.username == userNameCtrl.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('username has been taken!'),
            backgroundColor: MColors.red,
          ),
        );
        return;
      }
    }

    final newUser = const UserModel().copyWith(
      userId: listAuth.length + 1,
      username: userNameCtrl.text,
      password: passConfCtrl.text,
      avatar: '',
    );

    listAuth.add(newUser);
    await sharedPreferencesHelper
        .saveUserData(listAuth)
        .then((value) => goToLogin(context));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully create account!'),
        backgroundColor: MColors.p2,
      ),
    );

    clearForm();
  }

  Future<void> goToLogin(BuildContext context) async {
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.routeName, (route) => false);
  }
}
