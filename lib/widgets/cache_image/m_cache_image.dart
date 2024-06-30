import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MCacheImage extends StatefulWidget {
  const MCacheImage({
    super.key,
    required this.imagePath,
    this.errorWidget,
    this.progressIndicatorBuilder,
    this.boxFit = BoxFit.cover,
  });

  final String imagePath;

  final BoxFit boxFit;

  /// Widget displayed while the target [imagePath] failed loading.
  final Widget Function(BuildContext, String, dynamic)? errorWidget;

  /// Widget displayed while the target [imagePath] is loading.
  final Widget Function(BuildContext, String, DownloadProgress)?
      progressIndicatorBuilder;

  @override
  State<MCacheImage> createState() => _MCacheImageState();
}

class _MCacheImageState extends State<MCacheImage> {
  @override
  CachedNetworkImage build(BuildContext context) {
    return CachedNetworkImage(
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          widget.progressIndicatorBuilder != null
              ? widget.progressIndicatorBuilder!(
                  context,
                  url,
                  downloadProgress,
                )
              : _DefaultProgressIndicator(downloadProgress),
      errorWidget: (context, url, error) => widget.errorWidget != null
          ? widget.errorWidget!(context, url, error)
          : const Icon(Icons.error),
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      placeholderFadeInDuration: Duration.zero,
      imageUrl: widget.imagePath,
      fit: widget.boxFit,
    );
  }
}

class _DefaultProgressIndicator extends StatelessWidget {
  final DownloadProgress downloadProgress;

  const _DefaultProgressIndicator(
    this.downloadProgress,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        final bool horizontalImage =
            constraints.maxWidth > constraints.maxHeight;

        return FractionallySizedBox(
          widthFactor: horizontalImage ? null : 0.3,
          heightFactor: horizontalImage ? 0.3 : null,
          child: Center(
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
              ),
            ),
          ),
        );
      },
    );
  }
}
