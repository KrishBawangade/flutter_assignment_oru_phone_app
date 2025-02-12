import 'package:json_annotation/json_annotation.dart';

part 'brand_model.g.dart'; // This will be generated

@JsonSerializable()
class BrandResponse {
  final String reason;
  final int statusCode;
  final String status;
  final List<BrandDataObject> dataObject;

  BrandResponse({
    required this.reason,
    required this.statusCode,
    required this.status,
    required this.dataObject,
  });

  factory BrandResponse.fromJson(Map<String, dynamic> json) => _$BrandResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BrandResponseToJson(this);

}

@JsonSerializable()
class BrandDataObject {
  final String make;
  final String imagePath;

  BrandDataObject({
    required this.make,
    required this.imagePath,
  });

  factory BrandDataObject.fromJson(Map<String, dynamic> json) => _$BrandDataObjectFromJson(json);

  Map<String, dynamic> toJson() => _$BrandDataObjectToJson(this);
}