// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';

enum EmailType {
  preview,
  threaded,
  primaryThreaded,
}

class CategoryCardWidget extends StatefulWidget {
  const CategoryCardWidget({
    super.key,
    required this.category,
    this.isSelected = false,
    this.isPreview = true,
    this.isThreaded = false,
    this.showHeadline = false,
    this.onSelected,
    this.isMainCategory = true,
  });

  final bool isSelected;
  final bool isPreview;
  final bool showHeadline;
  final bool isThreaded;
  final bool isMainCategory;
  final void Function()? onSelected;
  final Category category;

  @override
  State<CategoryCardWidget> createState() => _CategoryCardWidgetState();
}

class _CategoryCardWidgetState extends State<CategoryCardWidget> {
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;
  late Color unselectedColor = Color.alphaBlend(
    _colorScheme.primary.withOpacity(0.08),
    _colorScheme.surface,
  );

  Color get _surfaceColor => switch (widget) {
        CategoryCardWidget(isPreview: false) => _colorScheme.surface,
        CategoryCardWidget(isSelected: true) => _colorScheme.primaryContainer,
        _ => unselectedColor,
      };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelected,
      child: Card(
        elevation: 0,
        color: _surfaceColor,
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            EmailHeadline(
              category: widget.category,
              isSelected: widget.isSelected,
            ),
            EmailContent(
              category: widget.category,
              isPreview: widget.isPreview,
              isThreaded: widget.isThreaded,
              isSelected: widget.isSelected,
            ),
          ],
        ),
      ),
    );
  }
}

class EmailContent extends StatefulWidget {
  const EmailContent({
    super.key,
    required this.category,
    required this.isPreview,
    required this.isThreaded,
    required this.isSelected,
  });

  final Category category;
  final bool isPreview;
  final bool isThreaded;
  final bool isSelected;

  @override
  State<EmailContent> createState() => _EmailContentState();
}

class _EmailContentState extends State<EmailContent> {
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;
  late final TextTheme _textTheme = Theme.of(context).textTheme;

  Widget get contentSpacer => SizedBox(height: widget.isThreaded ? 20 : 2);

  TextStyle? get contentTextStyle => switch (widget) {
        EmailContent(isThreaded: true) => _textTheme.bodyLarge,
        EmailContent(isSelected: true) => _textTheme.bodyMedium
            ?.copyWith(color: _colorScheme.onPrimaryContainer),
        _ =>
          _textTheme.bodyMedium?.copyWith(color: _colorScheme.onSurfaceVariant),
      };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (constraints.maxWidth - 200 > 0) ...[
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/image/ic_launcher.png'),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 6.0)),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.category.title,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: widget.isSelected
                            ? _textTheme.labelMedium?.copyWith(
                                color: _colorScheme.onSecondaryContainer)
                            : _textTheme.labelMedium
                                ?.copyWith(color: _colorScheme.onSurface),
                      ),
                      Text(
                        'Last Active',
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: widget.isSelected
                            ? _textTheme.labelMedium?.copyWith(
                                color: _colorScheme.onSecondaryContainer)
                            : _textTheme.labelMedium?.copyWith(
                                color: _colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              contentSpacer,
              Text(
                widget.category.title,
                maxLines: widget.isPreview ? 2 : 100,
                overflow: TextOverflow.ellipsis,
                style: contentTextStyle,
              ),
            ],
          ),
          const SizedBox(width: 12),
          const EmailReplyOptions(),
        ],
      ),
    );
  }
}

class EmailHeadline extends StatefulWidget {
  const EmailHeadline({
    super.key,
    required this.category,
    required this.isSelected,
  });

  final Category category;
  final bool isSelected;

  @override
  State<EmailHeadline> createState() => _EmailHeadlineState();
}

class _EmailHeadlineState extends State<EmailHeadline> {
  late final TextTheme _textTheme = Theme.of(context).textTheme;
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: 84,
        color: Color.alphaBlend(
          _colorScheme.primary.withOpacity(0.05),
          _colorScheme.surface,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 12, 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.category.title,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${widget.category.subCategory.length} SubCategory',
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: _textTheme.labelMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class EmailReplyOptions extends StatefulWidget {
  const EmailReplyOptions({super.key});

  @override
  State<EmailReplyOptions> createState() => _EmailReplyOptionsState();
}

class _EmailReplyOptionsState extends State<EmailReplyOptions> {
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(_colorScheme.onInverseSurface),
                ),
                onPressed: () {},
                child: Text(
                  'Reply',
                  style: TextStyle(color: _colorScheme.onSurfaceVariant),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
