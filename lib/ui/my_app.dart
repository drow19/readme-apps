import 'package:book_store_apps/constant/app_theme.dart';
import 'package:book_store_apps/constant/strings.dart';
import 'package:book_store_apps/data/local/shared_preferences.dart';
import 'package:book_store_apps/data/repositories/book_repository.dart';
import 'package:book_store_apps/di/components/service_locator.dart';
import 'package:book_store_apps/di/modules/navigation_service.dart';
import 'package:book_store_apps/routes.dart';
import 'package:book_store_apps/ui/home/favorite/favorite_screen_provider.dart';
import 'package:book_store_apps/ui/home/home/home_screen_provider.dart';
import 'package:book_store_apps/ui/home/main_screen_provider.dart';
import 'package:book_store_apps/ui/home/profile/profile_screen_provider.dart';
import 'package:book_store_apps/widgets/alert/m_top_alert.dart';
import 'package:book_store_apps/widgets/alert/src/toast_extention.dart';
import 'package:book_store_apps/widgets/alert/src/toast_list_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeScreenProvider(getIt<BookRepository>()),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileScreenProvider(getIt<SharedPreferencesHelper>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Strings.appName,
        navigatorKey: getIt<NavigationService>().navigatorKey,
        routes: ReadmeRoute(context).routes(),
        builder: (context, child) {
          // initialize TopAlert
          child = ToastListOverlay<WToast>(
            itemBuilder: (context, item, index, animation) =>
                _buildItem(context, item, index, animation),
            child: child!,
          );
          return child;
        },
        theme: AppThemeData.lightThemeData.copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    WToast item,
    int index,
    Animation<double> animation,
  ) {
    return ToastItem(
      animation: animation,
      item: item,
      onTap: () => context.hideToast(
        item,
        (context, animation) => _buildItem(context, item, index, animation),
      ),
    );
  }
}
