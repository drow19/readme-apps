import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/constant/m_typography.dart';
import 'package:book_store_apps/di/components/service_locator.dart';
import 'package:book_store_apps/di/modules/navigation_service.dart';
import 'package:book_store_apps/widgets/button/m_button.dart';
import 'package:book_store_apps/widgets/button/m_large_button.dart';
import 'package:book_store_apps/widgets/icon/m_icon.dart';
import 'package:book_store_apps/widgets/modal/m_modal.dart';
import 'package:flutter/material.dart';

BuildContext _context = getIt<NavigationService>().context!;

Future<bool?> showCameraPermissionModal() => mModal<bool>(
      context: _context,
      title: 'Enable Camera Access',
      isCloseBtn: false,
      modalContent: Column(
        children: [
          const MIcon(
            Icons.camera_alt,
            size: 64,
            color: MColors.p2,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Camera Access',
            style: MTypography.body3.copyWith(color: MColors.p1),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      widgetButton: [
        Expanded(
          child: MLargeButton(
            title: 'Go to setting',
            typeButton: MTypeButton.filled,
            onPressed: () {
              Navigator.pop(_context, true);
            },
          ),
        ),
      ],
    );

Future<bool?> showStoragePermissionModal() => mModal<bool>(
      context: _context,
      title: 'Storage Permission Access',
      isCloseBtn: false,
      modalContent: Column(
        children: [
          const MIcon(
            Icons.storage,
            size: 64,
            color: MColors.p2,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Storage Access',
            style: MTypography.body3.copyWith(color: MColors.p1),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      widgetButton: [
        Expanded(
          child: MLargeButton(
            title: 'Go to setting',
            typeButton: MTypeButton.filled,
            onPressed: () {
              Navigator.pop(_context, true);
            },
          ),
        ),
      ],
    );
