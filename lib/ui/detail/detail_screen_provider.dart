import 'dart:io';

import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/data/local/shared_preferences.dart';
import 'package:book_store_apps/data/repositories/book_repository.dart';
import 'package:book_store_apps/models/book_data_res.dart';
import 'package:book_store_apps/models/book_model_res.dart';
import 'package:book_store_apps/ui/detail/detail_screen.dart';
import 'package:book_store_apps/utils/favorite_helper.dart';
import 'package:book_store_apps/utils/permission/m_permission_access.dart';
import 'package:book_store_apps/widgets/alert/m_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:provider/provider.dart';

class DetailScreenProvider extends ChangeNotifier {
  final BookRepository _repository;
  final SharedPreferencesHelper _sharedPreferenceHelper;

  DetailScreenProvider(this._repository, this._sharedPreferenceHelper);

  bool isDownloading = false;

  BookDataRes book = const BookDataRes();

  List<BookDataRes> listOfSimilar = List<BookDataRes>.empty(growable: true);

  void initial(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      final argument = ModalRoute.of(context)?.settings.arguments;

      argument as Map<String, dynamic>;

      book = argument['argument'];

      // add current
      FavoriteHelper.addBook(book);

      // fetch similar books
      getSimilarBooks(context);

      notifyListeners();
    }
  }

  void updateIsDownloadingValue(bool value) {
    isDownloading = value;

    notifyListeners();
  }

  Future<void> getSimilarBooks(BuildContext context) async {
    try {
      BookModelRes data = await _repository.getSimilarBooks(
        start: '${book.authors?.first.birthYear ?? ''}',
        end: '${book.authors?.first.birthYear ?? ''}',
      );

      listOfSimilar = data.book ?? [];
    } catch (e) {
      debugPrint('error fetching similar book : $e');
      MSnackbar.show('Something went wrong!');
    } finally {
      notifyListeners();
    }
  }

  Future<void> download(BuildContext context) async {
    updateIsDownloadingValue(true);
    try {
      File? fileResult;
      final bool storagePermission = await MPermission.checkStoragePermission();

      String fileName = 'book-${book.authors?.first.name}';

      if (storagePermission) {
        fileResult = await _repository.downloadBook(
            book.format?.appStream ?? '', fileName);
      }

      if (context.mounted) {
        MSnackbar.show('Successfully downloaded!', alertColor: MColors.p1);
      }

      if (fileResult != null) {
        await OpenFilex.open(fileResult.path);
      }
    } catch (e) {
      MSnackbar.show('Something went wrong!');
      debugPrint('error downloading file : $e');
    } finally {
      updateIsDownloadingValue(false);
      notifyListeners();
    }
  }

  void addToFavorite() {
    FavoriteHelper.addToFavorite(book);

    notifyListeners();
  }

  void goToDetail(BuildContext context, BookDataRes book) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (_) => DetailScreenProvider(
            _repository,
            _sharedPreferenceHelper,
          ),
          child: const DetailScreen(),
        ),
        settings: RouteSettings(arguments: {'argument': book}),
      ),
    );
  }
}
