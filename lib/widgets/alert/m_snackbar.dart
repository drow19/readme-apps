import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/di/components/service_locator.dart';
import 'package:book_store_apps/di/modules/navigation_service.dart';
import 'package:flutter/material.dart';

class MSnackbar {
  MSnackbar._();

  static void show(String message, {Color? alertColor}) {
    final context = getIt<NavigationService>().context;

    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: alertColor ?? MColors.red,
      ),
    );
  }
}
