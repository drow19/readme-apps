import 'dart:convert';

import 'package:book_store_apps/data/local/shared_preferences.dart';
import 'package:book_store_apps/models/user_model.dart';
import 'package:flutter/material.dart';

class UserScreenProvider extends ChangeNotifier {
  final SharedPreferencesHelper _sharedPreferencesHelper;

  UserScreenProvider(this._sharedPreferencesHelper);

  List<UserModel> listOfUser = List<UserModel>.empty(growable: true);

  Future<void> fetchUser() async {
    final String userData = _sharedPreferencesHelper.userData;

    // decode user data if not empty
    if (userData.isNotEmpty) {
      try {
        List<dynamic> data = jsonDecode(userData);
        listOfUser = data.map((item) => UserModel.fromJson(item)).toList();
      } catch (e) {
        debugPrint('error decoding user data : $e');
        return;
      }
    }

    notifyListeners();
  }
}