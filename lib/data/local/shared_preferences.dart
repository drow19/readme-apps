import 'dart:convert';

import 'package:book_store_apps/data/local/keys.dart';
import 'package:book_store_apps/models/book_data_res.dart';
import 'package:book_store_apps/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesHelper(this._sharedPreferences);

  // save user data into local storage
  String get userData => _sharedPreferences.getString(Keys.USERDATA) ?? '';

  Future<void> saveUserData(List<UserModel> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(data);
    await prefs.setString(Keys.USERDATA, jsonString);
  }

  Future<void> deleteUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(Keys.USERDATA);
  }

  //-----------//

  // save user login or keep me login
  int get savedLogin => _sharedPreferences.getInt(Keys.SAVEDLOGIN) ?? -1;

  Future<void> saveUserLogin(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Keys.SAVEDLOGIN, value);
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(Keys.SAVEDLOGIN);
  }

  //-----------//

  // save book to favorite
  String get seenBook => _sharedPreferences.getString(Keys.SEEN) ?? '';

  Future<void> saveSeenBook(List<BookDataRes> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(data);
    await prefs.setString(Keys.SEEN, jsonString);
  }

  Future<void> deleteSeenBook() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(Keys.SEEN);
  }

  //-----------//

  Future<void> deleteLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    debugPrint(prefs.toString());
  }
}
