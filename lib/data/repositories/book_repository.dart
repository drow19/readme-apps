
import 'dart:io';

import 'package:book_store_apps/data/network/book_api.dart';
import 'package:book_store_apps/models/book_model_res.dart';

class BookRepository {
  final BookApi _api;

  BookRepository(this._api);

  Future<BookModelRes> getBookData({
    int page = 1,
    String search = '',
    String sort = '',
  }) async {
    final Map<String, dynamic> payload = {
      if (search.isNotEmpty) 'search': search,
      if (sort.isNotEmpty) 'sort': 'ascending',
      'page': page,
    };

    final BookModelRes baseData = await _api.getListBook(payload);

    if ((baseData.book?.isEmpty ?? false) || baseData.book == []) {
      return const BookModelRes();
    }

    BookModelRes result = baseData;

    return result;
  }

  Future<BookModelRes> getSimilarBooks({
    int page = 1,
    String? start,
    String? end,
  }) async {
    final Map<String, dynamic> payload = {
      'author_year_start': start,
      'author_year_end': end,
      'page': page,
    };

    final BookModelRes baseData = await _api.getListBook(payload);

    if ((baseData.book?.isEmpty ?? false) || baseData.book == []) {
      return const BookModelRes();
    }

    BookModelRes result = baseData;

    return result;
  }

  Future<File?> downloadBook(String url, String fileName) async {
    try {
      final File result = await _api.downLoadBook(url, fileName);

      return result;
    } catch (e) {
      return null;
    }
  }
}
