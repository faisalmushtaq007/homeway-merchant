import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';
import 'package:homemakers_merchant/utils/app_log.dart';

class DrawerEntity with AppEquatable {
  DrawerEntity({
    required this.drawerID,
    required this.drawerName,
    this.icon,
    this.textStyle,
    this.children = const [],
    this.onPressed,
    this.hasExpanded = false,
    this.hasOpened = true,
    this.leading,
    this.controller,
    this.expandedCrossAxisAlignment,
  }) {
    if (hasExpanded) {
      assert(controller != null, 'ExpansionTileController should not be null');
      assert(expandedCrossAxisAlignment != null, 'ExpandedCrossAxisAlignment should not be null');
    }
  }

  factory DrawerEntity.fromMap(Map<String, dynamic> map) {
    return DrawerEntity(
      drawerID: map['drawerID'] as int,
      drawerName: map['drawerName'] as String,
      icon: map['icon'] as Icon?,
      textStyle: map['textStyle'] as TextStyle?,
      children: map['children'] ?? <DrawerEntity>[] as List<DrawerEntity>,
      onPressed: map['onPressed'] as VoidCallback?,
      hasExpanded: map['hasExpanded'] as bool,
      hasOpened: map['hasOpened'] as bool,
    );
  }

  final int drawerID;
  final String drawerName;
  final Icon? icon;
  final TextStyle? textStyle;
  final List<DrawerEntity> children;
  final VoidCallback? onPressed;
  final bool hasExpanded;
  final bool hasOpened;
  final Widget? leading;
  final ExpansionTileController? controller;
  final CrossAxisAlignment? expandedCrossAxisAlignment;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        drawerID,
        drawerName,
        icon,
        textStyle,
        children,
        onPressed,
        hasExpanded,
        hasOpened,
        leading,
        controller,
        expandedCrossAxisAlignment,
      ];

  Map<String, dynamic> toMap() {
    return {
      'drawerID': drawerID,
      'drawerName': drawerName,
      'icon': icon,
      'textStyle': textStyle,
      'children': children,
      'onPressed': onPressed,
      'hasExpanded': hasExpanded,
      'hasOpened': hasOpened,
    };
  }

  DrawerEntity copyWith({
    int? drawerID,
    String? drawerName,
    Icon? icon,
    TextStyle? textStyle,
    List<DrawerEntity>? children,
    VoidCallback? onPressed,
    bool? hasExpanded,
    bool? hasOpened,
    Widget? leading,
    ExpansionTileController? controller,
    CrossAxisAlignment? expandedCrossAxisAlignment,
  }) {
    return DrawerEntity(
      drawerID: drawerID ?? this.drawerID,
      drawerName: drawerName ?? this.drawerName,
      icon: icon ?? this.icon,
      textStyle: textStyle ?? this.textStyle,
      children: children ?? this.children,
      onPressed: onPressed ?? this.onPressed,
      hasExpanded: hasExpanded ?? this.hasExpanded,
      hasOpened: hasOpened ?? this.hasOpened,
      leading: leading ?? this.leading,
      controller: controller ?? this.controller,
      expandedCrossAxisAlignment: expandedCrossAxisAlignment ?? this.expandedCrossAxisAlignment,
    );
  }
}
