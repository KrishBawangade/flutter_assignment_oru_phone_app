import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String userName;
  final String email;
  final String profilePicPath;
  final String city;
  final String state;
  final String mobileNumber;
  final bool isAccountExpired;
  final String createdDate;
  final List<dynamic> favListings;
  final List<dynamic> userListings;
  final String userType;
  final bool waOptIn;
  final String sessionId;

  UserModel({
    required this.userName,
    required this.email,
    required this.profilePicPath,
    required this.city,
    required this.state,
    required this.mobileNumber,
    required this.isAccountExpired,
    required this.createdDate,
    required this.favListings,
    required this.userListings,
    required this.userType,
    required this.waOptIn,
    required this.sessionId,
  });

  // Factory method to generate UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
