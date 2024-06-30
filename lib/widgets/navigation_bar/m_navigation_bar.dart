import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/constant/m_typography.dart';
import 'package:flutter/material.dart';

class CustomBottomAppBarItem {
  final dynamic iconData;
  final String? title;

  CustomBottomAppBarItem({this.iconData, @required this.title});
}

class MBottomNavAppBar extends StatelessWidget {
  const MBottomNavAppBar({
    super.key,
    @required this.items,
    this.height = 60.0,
    this.iconSize = 24.0,
    this.selectedColor = MColors.n6,
    this.selectedIndex = 0,
    required this.color,
    required this.onTabSelected,
  });

  final List<CustomBottomAppBarItem>? items;
  final double height;
  final double iconSize;
  final Color color;
  final Color selectedColor;
  final Function(int) onTabSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: MColors.n5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items!.length, (index) {
          var item = items![index];
          var color = index == selectedIndex ? MColors.p2 : MColors.n2;
          return MenuItem(
            icon: item.iconData,
            title: item.title!,
            color: color,
            height: height,
            iconSize: iconSize,
            selected: index == selectedIndex ? true : false,
            onPressed: () {
              onTabSelected(index);
            },
          );
        }),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    @required this.icon,
    @required this.title,
    this.height = 60,
    @required this.onPressed,
    this.iconSize = 24,
    this.color = MColors.p1,
    this.selected = false,
  });

  final dynamic icon;
  final String? title;
  final Color? color;
  final bool? selected;
  final double? height, iconSize;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //IF ICON TYPE ICON DATA
              if (icon != null && icon is IconData) ...[
                Icon(
                  icon,
                  color: color,
                  size: iconSize,
                ),
              ] else if (icon != null && icon is String) ...[
                Image.asset(
                  icon,
                  color: color,
                  width: iconSize,
                  height: iconSize,
                ),
              ] else ...[
                Icon(
                  Icons.build_circle_sharp,
                  color: color,
                  size: iconSize,
                ),
              ],
              const SizedBox(height: 6),
              Text(
                title!,
                style: selected!
                    ? MTypography.body1.copyWith(color: MColors.p1)
                    : MTypography.body3.copyWith(color: MColors.n1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
