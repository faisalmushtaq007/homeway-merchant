import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/universal/advanced_avatar/src/advanced_avatar.dart';

import 'package:homemakers_merchant/shared/widgets/universal/advanced_avatar/src/align_circular.dart';
import 'package:homemakers_merchant/shared/widgets/universal/advanced_avatar/src/string_extension.dart';
import 'package:homemakers_merchant/shared/widgets/universal/image_loader/image_helper.dart';
import 'package:homemakers_merchant/utils/image_type.dart';

part 'advanced_avatar_inherited.dart';

const _defaultAvatarSize = 40.0;
const _defaultAbbreviationFontSize = 15.0;

/// Advanced Avatar widget.
class AdvancedAvatar extends StatelessWidget {
  const AdvancedAvatar({
    Key? key,
    this.name,
    this.size = _defaultAvatarSize,
    this.imageProvider,
    this.margin,
    this.style,
    this.statusColor,
    this.statusSize = 12.0,
    this.statusAlignment = Alignment.bottomRight,
    this.decoration = const BoxDecoration(
      shape: BoxShape.circle,
      color: Color.fromRGBO(0, 0, 0, 1),
    ),
    this.foregroundDecoration,
    this.child,
    this.children = const <Widget>[],
    this.animated = false,
    this.duration = const Duration(milliseconds: 300),
    this.autoTextSize = false,
    required this.imagePath,
  }) : super(key: key);

  /// Used for creating initials. (Regex split by r'\s+\/')
  final String? name;

  /// Avatar size (width = height).
  final double size;

  /// Avatar image source exclusively with [child].
  final ImageProvider<Object>? imageProvider;

  /// Avatar margin.
  final EdgeInsetsGeometry? margin;

  /// Initials text style.
  final TextStyle? style;

  /// Status color.
  final Color? statusColor;

  /// Status size.
  final double statusSize;

  /// Status angle.
  final Alignment statusAlignment;

  /// Avatar decoration.
  final BoxDecoration decoration;

  /// Avatar foreground decoration.
  final BoxDecoration? foregroundDecoration;

  /// Child widget exclusively with [imageProvider].
  final Widget? child;

  /// Children widgets.
  final List<Widget> children;

  /// Use AnimatedContainer.
  final bool animated;

  /// AnimatedContainer duration.
  final Duration duration;

  /// Whether the [name] text should dynamically changes according to [size].
  final bool autoTextSize;

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final dynamicTextSize =
        _defaultAbbreviationFontSize * (size / _defaultAvatarSize);
    final textStyle = const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    ).merge(style);

    final sourceChild = DefaultTextStyle(
      style: autoTextSize
          ? textStyle.copyWith(fontSize: dynamicTextSize)
          : textStyle,
      child: imagePath == null
          ? Text(name.toAbbreviation())
          : ImageHelper(
              image: imagePath!,
              filterQuality: FilterQuality.high,
              borderRadius: BorderRadiusDirectional.circular(10),
              imageType: findImageType(imagePath!),
              imageShape: ImageShape.rectangle,
              boxFit: BoxFit.cover,
              width: size,
              height: size,
              defaultErrorBuilderColor: Colors.blueGrey,
              errorBuilder: child ?? Text(name.toAbbreviation()),
              loaderBuilder: const CircularProgressIndicator(),
              matchTextDirection: true,
              placeholderText: name ?? '',
              placeholderTextStyle: context.labelLarge!.copyWith(
                fontSize: 16,
              ),
            ),
    );

    return UnconstrainedBox(
      child: AdvancedAvatarInherited(
        radius: size / 2.0,
        child: Container(
          width: size,
          height: size,
          margin: margin,
          child: Stack(
            children: [
              if (animated)
                AnimatedContainer(
                  duration: duration,
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  decoration: decoration,
                  foregroundDecoration: foregroundDecoration,
                  child: sourceChild,
                )
              else
                Container(
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  decoration: decoration,
                  foregroundDecoration: foregroundDecoration,
                  child: sourceChild,
                ),
              if (statusColor != null)
                AlignCircular(
                  alignment: statusAlignment,
                  child: Container(
                    width: statusSize,
                    height: statusSize,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
              for (final child in children) child,
            ],
          ),
        ),
      ),
    );
  }
}
