import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/constant/m_typography.dart';
import 'package:book_store_apps/ui/introduction/splash/splash_screen_provider.dart';
import 'package:book_store_apps/widgets/icon/m_app_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashScreenProvider provider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.initialChecking(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    provider = context.watch<SplashScreenProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: MColors.n5,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: MAppIcon(
              image: 'assets/images/splash_icon.png',
            ),
          ),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   bottom: MediaQuery.sizeOf(context).height / 3.8,
          //   child: Text(
          //     'Read Me',
          //     textAlign: TextAlign.center,
          //     style: MTypography.title
          //         .copyWith(fontSize: 30, color: MColors.n1, letterSpacing: 2),
          //   ),
          // ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(color: MColors.p1),
          )
        ],
      ),
    );
  }
}
