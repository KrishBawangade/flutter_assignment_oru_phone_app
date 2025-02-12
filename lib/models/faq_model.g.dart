// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaqResponse _$FaqResponseFromJson(Map<String, dynamic> json) => FaqResponse(
      faqs: (json['FAQs'] as List<dynamic>?)
          ?.map((e) => Faq.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FaqResponseToJson(FaqResponse instance) =>
    <String, dynamic>{
      'FAQs': instance.faqs,
    };

Faq _$FaqFromJson(Map<String, dynamic> json) => Faq(
      id: json['_id'] as String?,
      question: json['question'] as String?,
      answer: json['answer'] as String?,
    );

Map<String, dynamic> _$FaqToJson(Faq instance) => <String, dynamic>{
      '_id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
    };
