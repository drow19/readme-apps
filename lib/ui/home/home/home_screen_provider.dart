import 'package:book_store_apps/data/repositories/book_repository.dart';
import 'package:book_store_apps/models/book_data_res.dart';
import 'package:book_store_apps/models/book_model_res.dart';
import 'package:book_store_apps/ui/detail/detail_screen.dart';
import 'package:book_store_apps/utils/favorite_helper.dart';
import 'package:book_store_apps/widgets/alert/m_snackbar.dart';
import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier {
  final BookRepository _repository;

  HomeScreenProvider(this._repository);

  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  int page = 1;
  bool hasNext = false;
  bool isLoading = false;
  bool isSearch = false;

  List<BookDataRes> listOfTrending = List<BookDataRes>.empty(growable: true);
  List<BookDataRes> listOfPopular = List<BookDataRes>.empty(growable: true);

  Future<void> initial(BuildContext context) async {
    Future.wait([
      getPopularBook(context),
      getTrendingBook(context),
    ]);
  }

  Future<void> getTrendingBook(BuildContext context) async {
    if(!hasNext) updateLoadingState(true);
    try {
      BookModelRes data = await _repository.getBookData(
        page: page,
        search: searchController.text,
        sort: 'ascending',
      );

      if (data.next != null || (data.next?.isNotEmpty ?? false)) {
        hasNext = true;
      } else {
        hasNext = false;
      }

      if (data.book != null || (data.book?.isNotEmpty ?? false)) {
        listOfTrending.addAll(data.book ?? []);
      }
    } catch (e) {
      debugPrint('error fetching trending book : $e');
      MSnackbar.show('Something went wrong!');
    } finally {
      updateLoadingState(false);
      notifyListeners();
    }
  }

  Future<void> getPopularBook(BuildContext context) async {
    try {
      BookModelRes data = await _repository.getBookData(
        page: page,
        search: searchController.text,
      );

      if (data.book != null || (data.book?.isNotEmpty ?? false)) {
        listOfPopular = data.book ?? [];
      }
    } catch (e) {
      debugPrint('error fetching popular book : $e');
      MSnackbar.show('Something went wrong!');
    } finally {
      notifyListeners();
    }
  }

  void updateLoadingState(bool value) {
    isLoading = value;

    notifyListeners();
  }

  void refreshPage(BuildContext context) async {
    page = 1;
    listOfTrending.clear();
    getTrendingBook(context);
    getPopularBook(context);

    notifyListeners();
  }

  void updateIsSearch() {
    isSearch = searchController.text.isNotEmpty;

    notifyListeners();
  }

  void addToFavorite(BookDataRes book) {
    FavoriteHelper.addToFavorite(book);

    notifyListeners();
  }

  void goToDetail(BuildContext context, BookDataRes book) {
    final Map<String, dynamic> argument = {'argument': book};

    Navigator.pushNamed(context, DetailScreen.routeName, arguments: argument);
  }
}
