import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:book_store_apps/widgets/modal/m_permission_modal.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class MPermission {
  MPermission._();

  static Future<bool> checkStoragePermission() async {
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;

      bool isGranted = false;
      if (deviceInfo.version.sdkInt > 32) {
        final isPhotoGranted = await Permission.photos.request().isGranted;
        final isVideoGranted = await Permission.videos.request().isGranted;
        final isAudioGranted = await Permission.audio.request().isGranted;

        isGranted = isPhotoGranted && isVideoGranted && isAudioGranted;
      } else {
        isGranted = await Permission.storage.request().isGranted;
      }

      if (!isGranted) {
        final bool? isOpenStorage = await showStoragePermissionModal();

        if (isOpenStorage ?? false) {
          await AppSettings.openAppSettings();
        }

        return false;
      }
    } else if (Platform.isIOS) {
      final photoGranted = await Permission.photos.request().isGranted;

      if (!photoGranted) {
        final bool? isOpenStorage = await showStoragePermissionModal();

        if (isOpenStorage ?? false) {
          await AppSettings.openAppSettings();
        }
        return false;
      }
    }

    return true;
  }
}
