import 'dart:async';

import 'package:book_store_apps/data/dio_client.dart';
import 'package:book_store_apps/data/local/shared_preferences.dart';
import 'package:book_store_apps/data/network/book_api.dart';
import 'package:book_store_apps/data/repositories/book_repository.dart';
import 'package:book_store_apps/di/modules/navigation_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

class Env {
  Env._();

  static const prod = 'prod';

  static const dev = 'test';
}

Future<void> setupLocator() async {
  getIt.registerLazySingleton(() => NavigationService());

  getIt.registerSingleton<SharedPreferencesHelper>(
    SharedPreferencesHelper(await SharedPreferences.getInstance()),
  );

  getIt.registerSingleton(
    DioClient(
      Dio(BaseOptions(baseUrl: 'https://gutendex.com/')),
    ),
    instanceName: Env.prod,
  );

  getIt.registerSingleton(
    BookApi(
      getIt.get<DioClient>(instanceName: Env.prod),
    ),
  );

  getIt.registerSingleton(BookRepository(getIt<BookApi>()));
}
