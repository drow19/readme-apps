import 'package:book_store_apps/data/dio_client.dart';

abstract class BaseApi {
  final String path;
  final DioClient dioClient;

  BaseApi(this.path, this.dioClient);

  String get bookPath => path;
}