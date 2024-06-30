import 'package:book_store_apps/widgets/alert/src/toast_list_overlay.dart';
import 'package:flutter/material.dart';

extension ToastListExtension on BuildContext {
  void showToast<T>(T text, bool isMultiple) {
    ToastListOverlay.of<T>(this).widget.timeoutDuration =
    const Duration(seconds: 5);
    ToastListOverlay.of<T>(this).show(this, text);
    ToastListOverlay.of<T>(this).widget.limit = isMultiple ? 5 : 1;
  }

  void showToastWithDuration<T>(T text, bool isMultiple, Duration? time) {
    ToastListOverlay.of<T>(this).widget.timeoutDuration = time;
    ToastListOverlay.of<T>(this).show(this, text);
    ToastListOverlay.of<T>(this).widget.limit = isMultiple ? 5 : 1;
  }

  void hideToast<T>(
      T item,
      Widget Function(BuildContext, Animation<double>) builder,
      ) {
    ToastListOverlay.of<T>(this).removeItem(item, builder);
  }
}