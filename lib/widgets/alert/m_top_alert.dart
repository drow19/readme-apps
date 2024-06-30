//Type of all alert
import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/constant/m_shadow.dart';
import 'package:book_store_apps/constant/m_typography.dart';
import 'package:book_store_apps/widgets/icon/m_icon.dart';
import 'package:flutter/material.dart';

enum ToastType { success, failed, warning, info, notification }

// get data item index and animation
typedef ToastListItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  int index,
  Animation<double> animation,
);

//time fo alert
class ToastTimer {
  int time;
  Duration duration;
  dynamic item;
  int index;

  ToastTimer(this.time, this.duration, this.item, this.index);
}

//model for alert Use name and type
class WToast {
  String message;
  ToastType type;
  IconData? icon;
  String? title;
  String? image;
  void Function()? onPress;

  WToast(
    this.message,
    this.type, {
    this.icon,
    this.title,
    this.image,
    this.onPress,
  });
}

class ToastItem extends StatelessWidget {
  const ToastItem({
    super.key,
    this.onTap,
    required this.animation,
    required this.item,
  });

  final Animation<double> animation;
  final VoidCallback? onTap;
  final WToast item;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = MTypography.body3.copyWith(color: MColors.p1);

    return GestureDetector(
      onTap: item.onPress ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: FadeTransition(
          opacity: animation,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [MShadow.p1Shadow1],
              color: MColors.n6,
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: SizeTransition(
              sizeFactor: animation,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: _getTypeColor(item.type),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                ),
                width: double.infinity,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: item.icon != null
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: MIcon(
                                    item.icon,
                                    size: 32,
                                    color: MColors.p1,
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (item.title?.isNotEmpty ?? false)
                                Text(
                                  item.title ?? '',
                                  style: MTypography.body1
                                      .copyWith(color: MColors.p1),
                                ),
                              DefaultTextStyle(
                                style: textStyle,
                                child: Text(
                                  item.message,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (item.type != ToastType.notification)
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () => onTap?.call(),
                              child: const MIcon(
                                Icons.close,
                                color: MColors.p1,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//set color for each type
  Color _getTypeColor(ToastType type) {
    switch (type) {
      case ToastType.success:
        return MColors.green.withOpacity(0.3);
      case ToastType.warning:
        return MColors.warning.withOpacity(0.3);
      case ToastType.info:
        return MColors.blue.withOpacity(0.3);
      case ToastType.failed:
        return MColors.red.withOpacity(0.3);
      case ToastType.notification:
        return MColors.p3.withOpacity(0.08);
    }
  }
}
