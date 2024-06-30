import 'dart:io';

import 'package:book_store_apps/data/dio_client.dart';
import 'package:book_store_apps/data/network/base_api.dart';
import 'package:book_store_apps/models/book_model_res.dart';
import 'package:external_path/external_path.dart';
import 'package:path_provider/path_provider.dart';

class BookApi extends BaseApi {
  BookApi(DioClient dioClient) : super('/books', dioClient);

  Future<BookModelRes> getListBook(Map<String, dynamic> payload) async {
    try {
      final response = await dioClient.get(
        bookPath,
        queryParameters: payload,
      );

      final BookModelRes data = BookModelRes.fromJson(response);

      return data;
    } catch (_) {
      rethrow;
    }
  }

  Future<File> downLoadBook(String url, String filename) async {
    try {
      final String fileNames = filename.replaceAll('/', '_');
      String savePath = '';

      if (Platform.isAndroid) {
        final downloadPath =
            await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS,
        );

        savePath = '$downloadPath/$fileNames.zip';
      } else if (Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();

        savePath = '${directory.path}/$fileNames.zip';
      }

      await dioClient.download(url, savePath);

      final File file = File(savePath);

      return file;
    } catch (_) {
      rethrow;
    }
  }
}
