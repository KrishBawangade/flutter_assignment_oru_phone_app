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
  final List<String> favListings; // Assuming it's a list of strings
  final List<dynamic> userListings; // Keep dynamic if structure is unknown
  final String userType;
  
  @JsonKey(name: "WAOptIn") // Fix the JSON key mapping
  final bool? waOptIn;
  
  final String? sessionId; // Make sessionId optional

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
    this.sessionId, // Optional sessionId
  });

  // Factory method to generate UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
