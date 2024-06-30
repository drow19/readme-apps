import 'dart:convert';

import 'package:book_store_apps/data/local/shared_preferences.dart';
import 'package:book_store_apps/di/components/service_locator.dart';
import 'package:book_store_apps/models/book_data_res.dart';
import 'package:book_store_apps/models/user_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class FavoriteHelper {
  FavoriteHelper._();

  static bool updateFavIconColor(BookDataRes book) {
    final sharedPreferenceHelper = getIt<SharedPreferencesHelper>();

    final int userLogin = sharedPreferenceHelper.savedLogin;
    final String userData = sharedPreferenceHelper.userData;

    // Decode user data if not empty
    if (userData.isNotEmpty) {
      try {
        List<dynamic> data = jsonDecode(userData);
        List<UserModel> listUser =
            data.map((item) => UserModel.fromJson(item)).toList();

        // Find the current user
        final UserModel? sameUser =
            listUser.firstWhereOrNull((user) => user.userId == userLogin);

        if (sameUser != null) {
          // Check if the book is in the favorite list
          return sameUser.favorite?.any((b) => b.id == book.id) ?? false;
        }
      } catch (e) {
        debugPrint('Error decoding user data: $e');
      }
    }

    // If user data is empty, user not found, or an error occurs, return false
    return false;
  }

  static void addToFavorite(BookDataRes book) async {
    final sharedPreferenceHelper = getIt<SharedPreferencesHelper>();

    final int userLogin = sharedPreferenceHelper.savedLogin;
    final String userData = sharedPreferenceHelper.userData;

    List<UserModel> listUser = List<UserModel>.empty(growable: true);

    // decode user data if not empty
    if (userData.isNotEmpty) {
      try {
        List<dynamic> data = jsonDecode(userData);
        listUser = data.map((item) => UserModel.fromJson(item)).toList();
      } catch (e) {
        debugPrint('error decoding user data : $e');
        return;
      }
    }

    // find the current user
    final UserModel? sameUser =
        listUser.firstWhereOrNull((user) => user.userId == userLogin);

    if (sameUser == null) return;

    // update the favorite book list
    List<BookDataRes> listOfBook = sameUser.favorite ?? [];

    if (listOfBook.any((b) => b.id == book.id)) {
      listOfBook.removeWhere((b) => b.id == book.id);
    } else {
      listOfBook.add(book);
    }

    // create an updated user model with the new favorite list
    UserModel updateUser = sameUser.copyWith(favorite: listOfBook);

    int userIndex = listUser.indexOf(sameUser);
    listUser[userIndex] = updateUser;

    sharedPreferenceHelper.saveUserData(listUser);
  }

  static Future<List<BookDataRes>> getListFavorite() async {
    final sharedPreferenceHelper = getIt<SharedPreferencesHelper>();

    final int userLogin = sharedPreferenceHelper.savedLogin;
    final String userData = sharedPreferenceHelper.userData;

    // Return an empty list if user data is empty
    if (userData.isEmpty) return [];

    try {
      List<dynamic> data = jsonDecode(userData);
      List<UserModel> listUser =
          data.map((item) => UserModel.fromJson(item)).toList();

      // Find the current user
      final UserModel? sameUser =
          listUser.firstWhereOrNull((user) => user.userId == userLogin);

      // Return the favorite list of the found user, or an empty list if the user is not found
      return sameUser?.favorite ?? [];
    } catch (e) {
      debugPrint('Error decoding user data: $e');
      return [];
    }
  }

  static void addBook(BookDataRes book) async {
    final sharedPreferenceHelper = getIt<SharedPreferencesHelper>();

    // Retrieve the saved book data
    String bookData = sharedPreferenceHelper.seenBook;
    List<BookDataRes> listOfBooks = [];

    // Decode the saved book data if it's not empty
    if (bookData.isNotEmpty) {
      try {
        List<dynamic> data = jsonDecode(bookData);
        listOfBooks = data.map((item) => BookDataRes.fromJson(item)).toList();
      } catch (e) {
        debugPrint('Error decoding books data: $e');
        return;
      }
    }

    // Add the new book to the list
    listOfBooks.add(book);

    // Maintain a maximum of 5 books in the list
    if (listOfBooks.length > 5) {
      listOfBooks.removeAt(0);
    }

    // Save the updated list of books
    await sharedPreferenceHelper.saveSeenBook(listOfBooks);
  }
}
