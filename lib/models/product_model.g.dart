// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      data: json['data'] == null
          ? null
          : ProductData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ProductData _$ProductDataFromJson(Map<String, dynamic> json) => ProductData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductDataToJson(ProductData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['_id'] as String?,
      deviceCondition: json['deviceCondition'] as String?,
      listedBy: json['listedBy'] as String?,
      deviceStorage: json['deviceStorage'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultImage: json['defaultImage'] == null
          ? null
          : ProductDefaultImage.fromJson(
              json['defaultImage'] as Map<String, dynamic>),
      listingState: json['listingState'] as String?,
      listingLocation: json['listingLocation'] as String?,
      listingLocality: json['listingLocality'] as String?,
      listingPrice: json['listingPrice'] as String?,
      make: json['make'] as String?,
      marketingName: json['marketingName'] as String?,
      openForNegotiation: json['openForNegotiation'] as bool?,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      verified: json['verified'] as bool?,
      listingId: json['listingId'] as String?,
      status: json['status'] as String?,
      verifiedDate: json['verifiedDate'] as String?,
      listingDate: json['listingDate'] as String?,
      deviceRam: json['deviceRam'] as String?,
      warranty: json['warranty'] as String?,
      imagePath: json['imagePath'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      location: json['location'] == null
          ? null
          : ProductLocation.fromJson(json['location'] as Map<String, dynamic>),
      originalPrice: (json['originalPrice'] as num?)?.toInt(),
      discountedPrice: (json['discountedPrice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'deviceCondition': instance.deviceCondition,
      'listedBy': instance.listedBy,
      'deviceStorage': instance.deviceStorage,
      'images': instance.images,
      'defaultImage': instance.defaultImage,
      'listingState': instance.listingState,
      'listingLocation': instance.listingLocation,
      'listingLocality': instance.listingLocality,
      'listingPrice': instance.listingPrice,
      'make': instance.make,
      'marketingName': instance.marketingName,
      'openForNegotiation': instance.openForNegotiation,
      'discountPercentage': instance.discountPercentage,
      'verified': instance.verified,
      'listingId': instance.listingId,
      'status': instance.status,
      'verifiedDate': instance.verifiedDate,
      'listingDate': instance.listingDate,
      'deviceRam': instance.deviceRam,
      'warranty': instance.warranty,
      'imagePath': instance.imagePath,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'location': instance.location,
      'originalPrice': instance.originalPrice,
      'discountedPrice': instance.discountedPrice,
    };

ProductImage _$ProductImageFromJson(Map<String, dynamic> json) => ProductImage(
      thumbImage: json['thumbImage'] as String?,
      fullImage: json['fullImage'] as String?,
      isVarified: json['isVarified'] as String?,
      option: json['option'] as String?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$ProductImageToJson(ProductImage instance) =>
    <String, dynamic>{
      'thumbImage': instance.thumbImage,
      'fullImage': instance.fullImage,
      'isVarified': instance.isVarified,
      'option': instance.option,
      '_id': instance.id,
    };

ProductDefaultImage _$ProductDefaultImageFromJson(Map<String, dynamic> json) =>
    ProductDefaultImage(
      fullImage: json['fullImage'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ProductDefaultImageToJson(
        ProductDefaultImage instance) =>
    <String, dynamic>{
      'fullImage': instance.fullImage,
      'id': instance.id,
    };

ProductLocation _$ProductLocationFromJson(Map<String, dynamic> json) =>
    ProductLocation(
      type: json['type'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ProductLocationToJson(ProductLocation instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
      'id': instance.id,
    };
