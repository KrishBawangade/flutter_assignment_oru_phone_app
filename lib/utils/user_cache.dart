import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserCache {
  static const String _userModelKey = 'user_model';
  static const String _isLoggedInKey = 'is_logged_in';
  static final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  // User Model Operations
  static Future<void> saveUserModel(UserModel userModel) async {
    final userJson = json.encode(userModel.toJson());
    await _prefs.setString(_userModelKey, userJson);
  }

  static Future<UserModel?> getUserModel() async {
    
    final userJson = await _prefs.getString(_userModelKey);
    if (userJson != null) {
      return UserModel.fromJson(json.decode(userJson));
    }
    return null;
  }

  static Future<void> deleteUserModel() async {
    await _prefs.remove(_userModelKey);
    await _prefs.remove(_isLoggedInKey);
  }

}