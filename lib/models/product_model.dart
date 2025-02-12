import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductResponse {
  final ProductData? data; // Make data nullable

  ProductResponse({this.data});

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

@JsonSerializable()
class ProductData {
  final List<Product>? data; // Make data nullable

  ProductData({this.data});

  factory ProductData.fromJson(Map<String, dynamic> json) =>
      _$ProductDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDataToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: "_id")
  final String? id;
  final String? deviceCondition;
  final String? listedBy;
  final String? deviceStorage;
  final List<ProductImage>? images;
  final ProductDefaultImage? defaultImage;
  final String? listingState;
  final String? listingLocation;
  final String? listingLocality;
  final String? listingPrice;
  final String? make;
  final String? marketingName;
  final bool? openForNegotiation;
  final double? discountPercentage;
  final bool? verified;
  final String? listingId;
  final String? status;
  final String? verifiedDate;
  final String? listingDate;
  final String? deviceRam;
  final String? warranty;
  final String? imagePath;
  final String? createdAt;
  final String? updatedAt;
  final ProductLocation? location;
  final int? originalPrice;
  final int? discountedPrice;

  Product({
    this.id,
    this.deviceCondition,
    this.listedBy,
    this.deviceStorage,
    this.images,
    this.defaultImage,
    this.listingState,
    this.listingLocation,
    this.listingLocality,
    this.listingPrice,
    this.make,
    this.marketingName,
    this.openForNegotiation,
    this.discountPercentage,
    this.verified,
    this.listingId,
    this.status,
    this.verifiedDate,
    this.listingDate,
    this.deviceRam,
    this.warranty,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
    this.location,
    this.originalPrice,
    this.discountedPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class ProductImage {
  final String? thumbImage;
  final String? fullImage;
  final String? isVarified;
  final String? option;
  @JsonKey(name: "_id")
  final String? id;

  ProductImage({
    this.thumbImage,
    this.fullImage,
    this.isVarified,
    this.option,
    this.id,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) =>
      _$ProductImageFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImageToJson(this);
}

@JsonSerializable()
class ProductDefaultImage {
  final String? fullImage;
  final String? id;

  ProductDefaultImage({this.fullImage, this.id});

  factory ProductDefaultImage.fromJson(Map<String, dynamic> json) =>
      _$ProductDefaultImageFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDefaultImageToJson(this);
}

@JsonSerializable()
class ProductLocation {
  final String? type;
  final List<double>? coordinates;
  final String? id;

  ProductLocation({this.type, this.coordinates, this.id});

  factory ProductLocation.fromJson(Map<String, dynamic> json) =>
      _$ProductLocationFromJson(json);

  Map<String, dynamic> toJson() => _$ProductLocationToJson(this);
}