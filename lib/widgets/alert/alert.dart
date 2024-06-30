import 'package:book_store_apps/di/components/service_locator.dart';
import 'package:book_store_apps/di/modules/navigation_service.dart';
import 'package:book_store_apps/widgets/alert/m_top_alert.dart';
import 'package:book_store_apps/widgets/alert/src/toast_extention.dart';
import 'package:flutter/material.dart';

class Alert {
  Alert._();

  static void show(
      String? message, {
        bool? isMultiple,
        Duration? timeoutDuration,
        IconData? icon,
        String? title,
        String? image,
        required ToastType type,
        void Function()? onPress,
      }) {
    final NavigationService navigationService = getIt<NavigationService>();
    final BuildContext? currentContext = navigationService.context;
    if (currentContext == null) return;

    currentContext.showToastWithDuration<WToast>(
      WToast(
        message ?? '',
        type,
        icon: icon,
        title: title,
        image: image,
        onPress: onPress,
      ),
      isMultiple ?? false,
      timeoutDuration ?? const Duration(seconds: 5),
    );
  }
}