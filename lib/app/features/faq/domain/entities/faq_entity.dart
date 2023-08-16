part of 'package:homemakers_merchant/app/features/faq/index.dart';

class FaqEntity with AppEquatable {
  FaqEntity({
    required this.faqID,
    required this.question,
    required this.answer,
  });

  factory FaqEntity.fromJson(Map<String, dynamic> map) {
    return FaqEntity(
      faqID: map['faqID'] as int,
      question: map['question'] as String,
      answer: map['answer'] as String,
    );
  }
  final int faqID;
  final String question;
  final String answer;

  @override
  String toString() {
    return 'FaqEntity{ faqID: $faqID, question: $question, answer: $answer,}';
  }

  FaqEntity copyWith({
    int? faqID,
    String? question,
    String? answer,
  }) {
    return FaqEntity(
      faqID: faqID ?? this.faqID,
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'faqID': this.faqID,
      'question': this.question,
      'answer': this.answer,
    };
  }

  @override
  bool get cacheHash => true;

  @override
  // TODO: implement hashParameters
  List<Object?> get hashParameters => [faqID, question, answer];
}
