import 'package:book_store_apps/data/local/shared_preferences.dart';
import 'package:book_store_apps/data/repositories/book_repository.dart';
import 'package:book_store_apps/di/components/service_locator.dart';
import 'package:book_store_apps/ui/detail/detail_screen.dart';
import 'package:book_store_apps/ui/detail/detail_screen_provider.dart';
import 'package:book_store_apps/ui/home/main_screen.dart';
import 'package:book_store_apps/ui/home/main_screen_provider.dart';
import 'package:book_store_apps/ui/home/user/user_screen.dart';
import 'package:book_store_apps/ui/home/user/user_screen_provider.dart';
import 'package:book_store_apps/ui/introduction/login/login_screen.dart';
import 'package:book_store_apps/ui/introduction/login/login_screen_provider.dart';
import 'package:book_store_apps/ui/introduction/register/register_screen.dart';
import 'package:book_store_apps/ui/introduction/register/register_screen_provider.dart';
import 'package:book_store_apps/ui/introduction/splash/splash_screen.dart';
import 'package:book_store_apps/ui/introduction/splash/splash_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReadmeRoute {
  final BuildContext _context;

  ReadmeRoute(this._context);

  Map<String, WidgetBuilder> routes() => {
        SplashScreen.routeName: (context) => ChangeNotifierProvider(
              create: (_) => SplashScreenProvider(
                getIt<SharedPreferencesHelper>(),
              ),
              child: const SplashScreen(),
            ),
        LoginScreen.routeName: (context) => ChangeNotifierProvider(
              create: (_) => LoginScreenProvider(
                getIt<SharedPreferencesHelper>(),
              ),
              child: const LoginScreen(),
            ),
        RegisterScreen.routeName: (context) => ChangeNotifierProvider(
              create: (_) => RegisterScreenProvider(
                getIt<SharedPreferencesHelper>(),
              ),
              child: const RegisterScreen(),
            ),
        MainScreen.routeName: (context) => ChangeNotifierProvider(
              create: (_) => MainScreenProvider(),
              child: const MainScreen(),
            ),
        DetailScreen.routeName: (context) => ChangeNotifierProvider(
              create: (_) => DetailScreenProvider(
                getIt<BookRepository>(),
                getIt<SharedPreferencesHelper>(),
              ),
              child: const DetailScreen(),
            ),
        UserScreen.routeName: (context) => ChangeNotifierProvider(
              create: (_) => UserScreenProvider(
                getIt<SharedPreferencesHelper>(),
              ),
              child: const UserScreen(),
            ),
      };
}
