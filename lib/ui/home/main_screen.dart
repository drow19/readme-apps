import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/ui/home/main_screen_provider.dart';
import 'package:book_store_apps/widgets/navigation_bar/m_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/home';

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainScreenProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    provider = context.watch<MainScreenProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: provider.getContentBody(),
        bottomNavigationBar: MBottomNavAppBar(
          color: MColors.n6,
          selectedColor: MColors.p1,
          onTabSelected: provider.selectedMenu,
          selectedIndex: provider.currentMenu,
          items: provider.listMenu
              .map((menu) => CustomBottomAppBarItem(
                  title: provider.titleMenu(menu),
                  iconData: provider.iconMenu(menu)))
              .toList(),
        ),
      ),
    );
  }
}
