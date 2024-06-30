import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/constant/m_typography.dart';
import 'package:book_store_apps/widgets/icon/m_icon.dart';
import 'package:flutter/material.dart';

Future<T?> mModal<T>({
  required BuildContext context,
  required String title,
  Color? colorCloseBtn,
  double? contentHeight,
  Widget? modalContent,
  List<Widget>? widgetButton,
  void Function()? onClose,
  bool isBarrierDismissible = true,
  bool isCenterContent = true,
  bool isCloseBtn = true,
  bool isHorizontalBtn = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: isBarrierDismissible,
    barrierColor: MColors.p1.withOpacity(0.8),
    builder: (BuildContext context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Center(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 50),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: const BoxDecoration(
                  color: MColors.n6,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  crossAxisAlignment: isCenterContent
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: isCloseBtn
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isCloseBtn)
                          const SizedBox(
                            width: 48,
                          ),
                        Flexible(
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(
                              minHeight: 32,
                            ),
                            child: Text(
                              title,
                              style:
                                  MTypography.title.copyWith(color: MColors.p1),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        if (isCloseBtn)
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(left: 16),
                              child: MIcon(
                                Icons.close,
                                color: colorCloseBtn ?? MColors.p1,
                              ),
                            ),
                          ),
                      ],
                    ),
                    if (modalContent != null)
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 32,
                            bottom: (widgetButton != null) ? 32 : 0,
                          ),
                          child: SizedBox(
                            height: contentHeight,
                            child: SingleChildScrollView(child: modalContent),
                          ),
                        ),
                      ),
                    if (isHorizontalBtn)
                      Row(
                        children: widgetButton ?? [const SizedBox()],
                      )
                    else
                      Column(
                        children: widgetButton ?? [const SizedBox()],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  ).then((value) {
    onClose?.call();
    return value;
  });
}
