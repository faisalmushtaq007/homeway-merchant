import 'package:flutter/cupertino.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';

class StoreEntity with AppEquatable {
  StoreEntity({
    required this.title,
    required this.titleID,
    required this.onPressed,
    required this.leading,
    this.trailing,
    this.style,
    this.hasEntityStored = true,
  });

  factory StoreEntity.fromMap(Map<String, dynamic> map) {
    return StoreEntity(
      title: map['title'] as String,
      titleID: map['titleID'] as int,
      onPressed: map['onPressed'] as VoidCallback,
      leading: map['leading'] as Icon,
      trailing: map['trailing'] as Icon,
      style: map['style'] as TextStyle,
      hasEntityStored: map['hasEntityStored'] as bool,
    );
  }

  final String title;
  final int titleID;
  final VoidCallback onPressed;
  final Icon leading;
  final Icon? trailing;
  final TextStyle? style;
  final bool hasEntityStored;

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'titleID': this.titleID,
      'onPressed': this.onPressed,
      'leading': this.leading,
      'trailing': this.trailing,
      'style': this.style,
      'hasEntityStored': this.hasEntityStored,
    };
  }

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        title,
        titleID,
        leading,
        trailing,
        style,
        hasEntityStored,
      ];
}
