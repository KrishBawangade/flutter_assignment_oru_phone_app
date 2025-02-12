import 'package:json_annotation/json_annotation.dart';

part 'filter_model.g.dart';

@JsonSerializable()
class FilterResponse {
  final String? reason;
  final int? statusCode;
  final String? status;
  final FilterData? dataObject;

  FilterResponse({this.reason, this.statusCode, this.status, this.dataObject});

  factory FilterResponse.fromJson(Map<String, dynamic> json) =>
      _$FilterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FilterResponseToJson(this);
}

@JsonSerializable()
class FilterData {
  @JsonKey(name: "Brand")
  final List<String>? brand;
  @JsonKey(name: "Ram")
  final List<String>? ram;
  @JsonKey(name: "Storage")
  final List<String>? storage;
  @JsonKey(name: "Conditions")
  final List<String>? conditions;
  @JsonKey(name: "Warranty")
  final List<String>? warranty;

  FilterData({this.brand, this.ram, this.storage, this.conditions, this.warranty});

  factory FilterData.fromJson(Map<String, dynamic> json) =>
      _$FilterDataFromJson(json);

  Map<String, dynamic> toJson() => _$FilterDataToJson(this);
}