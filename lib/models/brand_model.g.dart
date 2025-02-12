// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandResponse _$BrandResponseFromJson(Map<String, dynamic> json) =>
    BrandResponse(
      reason: json['reason'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
      status: json['status'] as String,
      dataObject: (json['dataObject'] as List<dynamic>)
          .map((e) => BrandDataObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BrandResponseToJson(BrandResponse instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'statusCode': instance.statusCode,
      'status': instance.status,
      'dataObject': instance.dataObject,
    };

BrandDataObject _$BrandDataObjectFromJson(Map<String, dynamic> json) =>
    BrandDataObject(
      make: json['make'] as String,
      imagePath: json['imagePath'] as String,
    );

Map<String, dynamic> _$BrandDataObjectToJson(BrandDataObject instance) =>
    <String, dynamic>{
      'make': instance.make,
      'imagePath': instance.imagePath,
    };
