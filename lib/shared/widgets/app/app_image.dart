import 'dart:math';

import 'package:flutter/material.dart';
import 'package:homemakers_merchant/shared/widgets/app/app_loading_indicators.dart';
import 'package:homemakers_merchant/utils/common/retry_image.dart';
import 'package:image_fade/image_fade.dart';

class AppImage extends StatefulWidget {
  const AppImage({
    super.key,
    required this.image,
    this.fit = BoxFit.scaleDown,
    this.alignment = Alignment.center,
    this.duration,
    this.syncDuration,
    this.distractor = false,
    this.progress = false,
    this.color,
    this.scale,
  });

  final ImageProvider? image;
  final BoxFit fit;
  final Alignment alignment;
  final Duration? duration;
  final Duration? syncDuration;
  final bool distractor;
  final bool progress;
  final Color? color;
  final double? scale;

  @override
  State<AppImage> createState() => _AppImageState();
}

class _AppImageState extends State<AppImage> {
  ImageProvider? _displayImage;
  ImageProvider? _sourceImage;

  @override
  void didChangeDependencies() {
    _updateImage();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(AppImage oldWidget) {
    _updateImage();
    super.didUpdateWidget(oldWidget);
  }

  void _updateImage() {
    if (widget.image == _sourceImage) return;
    _sourceImage = widget.image;
    _displayImage = _capImageSize(_addRetry(_sourceImage));
  }

  @override
  Widget build(BuildContext context) {
    return ImageFade(
      image: _displayImage,
      fit: widget.fit,
      alignment: widget.alignment,
      duration: widget.duration ?? const Duration(milliseconds: 300),
      syncDuration: widget.syncDuration ?? Duration.zero,
      loadingBuilder: (_, value, ___) {
        if (!widget.distractor && !widget.progress) return const SizedBox();
        return Center(
            child: AppLoadingIndicator(
                value: widget.progress ? value : null, color: widget.color));
      },
      errorBuilder: (_, __) => Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: LayoutBuilder(builder: (_, constraints) {
          final double size =
              min(constraints.biggest.width, constraints.biggest.height);
          if (size < 16) return const SizedBox();
          return Icon(
            Icons.image_not_supported_outlined,
            color: Colors.white.withOpacity(0.1),
            size: min(size, 32),
          );
        }),
      ),
    );
  }

  ImageProvider? _addRetry(ImageProvider? image) {
    return image == null ? image : RetryImage(image);
  }

  ImageProvider? _capImageSize(ImageProvider? image) {
    if (image == null || widget.scale == null) return image;
    final MediaQueryData mq = MediaQuery.of(context);
    final Size screenSize = mq.size * mq.devicePixelRatio * widget.scale!;
    return ResizeImage(image, width: screenSize.width.round());
  }
}
