// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterResponse _$FilterResponseFromJson(Map<String, dynamic> json) =>
    FilterResponse(
      reason: json['reason'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      status: json['status'] as String?,
      dataObject: json['dataObject'] == null
          ? null
          : FilterData.fromJson(json['dataObject'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FilterResponseToJson(FilterResponse instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'statusCode': instance.statusCode,
      'status': instance.status,
      'dataObject': instance.dataObject,
    };

FilterData _$FilterDataFromJson(Map<String, dynamic> json) => FilterData(
      brand:
          (json['Brand'] as List<dynamic>?)?.map((e) => e as String).toList(),
      ram: (json['Ram'] as List<dynamic>?)?.map((e) => e as String).toList(),
      storage:
          (json['Storage'] as List<dynamic>?)?.map((e) => e as String).toList(),
      conditions: (json['Conditions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      warranty: (json['Warranty'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FilterDataToJson(FilterData instance) =>
    <String, dynamic>{
      'Brand': instance.brand,
      'Ram': instance.ram,
      'Storage': instance.storage,
      'Conditions': instance.conditions,
      'Warranty': instance.warranty,
    };
