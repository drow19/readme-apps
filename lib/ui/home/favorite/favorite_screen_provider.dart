import 'package:book_store_apps/models/book_data_res.dart';
import 'package:book_store_apps/ui/detail/detail_screen.dart';
import 'package:book_store_apps/utils/favorite_helper.dart';
import 'package:flutter/material.dart';

class FavoriteScreenProvider extends ChangeNotifier {
  List<BookDataRes> listOfFavorite = List<BookDataRes>.empty();

  void getFavoriteBooks() async {
    listOfFavorite = await FavoriteHelper.getListFavorite();

    notifyListeners();
  }

  void addToFavorite(BookDataRes book) {
    FavoriteHelper.addToFavorite(book);
    listOfFavorite.remove(book);

    notifyListeners();
  }

  void goToDetail(BuildContext context, BookDataRes book) {
    final Map<String, dynamic> argument = {'argument': book};

    Navigator.pushNamed(context, DetailScreen.routeName, arguments: argument);
  }
}
