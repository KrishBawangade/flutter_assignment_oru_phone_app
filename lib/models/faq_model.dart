import 'package:json_annotation/json_annotation.dart';

part 'faq_model.g.dart';

@JsonSerializable()
class FaqResponse {
  @JsonKey(name: "FAQs")
  final List<Faq>? faqs;

  FaqResponse({this.faqs});

  factory FaqResponse.fromJson(Map<String, dynamic> json) =>
      _$FaqResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FaqResponseToJson(this);
}


@JsonSerializable()
class Faq {
  @JsonKey(name: "_id")
  final String? id;
  final String? question;
  final String? answer;

  Faq({this.id, this.question, this.answer});

  factory Faq.fromJson(Map<String, dynamic> json) => _$FaqFromJson(json);

  Map<String, dynamic> toJson() => _$FaqToJson(this);
}