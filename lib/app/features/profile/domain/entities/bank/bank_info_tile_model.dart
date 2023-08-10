part of 'package:homemakers_merchant/app/features/profile/index.dart';

class BankInfoTile {
//<editor-fold desc="Data Methods">
  const BankInfoTile({
    required this.label,
    required this.content,
  });

  factory BankInfoTile.fromMap(Map<String, dynamic> map) {
    return BankInfoTile(
      label: map['label'] as String,
      content: map['content'] as String,
    );
  }
  final String label;
  final String content;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is BankInfoTile && runtimeType == other.runtimeType && label == other.label && content == other.content);

  @override
  int get hashCode => label.hashCode ^ content.hashCode;

  @override
  String toString() {
    return 'BankInfoTile{' + ' label: $label,' + ' content: $content,' + '}';
  }

  BankInfoTile copyWith({
    String? label,
    String? content,
  }) {
    return BankInfoTile(
      label: label ?? this.label,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'label': this.label,
      'content': this.content,
    };
  }

//</editor-fold>
}
