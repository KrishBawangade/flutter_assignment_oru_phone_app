import 'package:flutter/material.dart';
import 'package:flutter_assignment_oru_phone_app/models/user_model.dart';
import 'package:flutter_assignment_oru_phone_app/utils/user_cache.dart';
import '../services/api_service.dart';
import '../utils/token_cache.dart';

class UserAuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  String? _csrfToken;
  bool _isLoading = false;
  String? _errorMessage;

  int? _countryCode;
  int? _mobileNumber;
  String? _userName; 
  UserModel? _userData;
  String? _cookie;

  String? get csrfToken => _csrfToken;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int? get countryCode => _countryCode;
  int? get mobileNumber => _mobileNumber;
  String? get userName => _userName; 
  UserModel? get userData => _userData; 
  String? get cookie => _cookie; 

  /// **🔹 Helper Method to Set Loading State**
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// **🔹 Helper Method to Handle Errors**
  void _handleError(dynamic e, Function(String)? onError) {
    _errorMessage = e.toString().replaceFirst("Exception: ", "");
    notifyListeners();
    if (onError != null) {
      onError(_errorMessage!);
    }
  }

  /// **✏️ Set User Name**
  void setUserName(String name, {Function()? onSuccess, Function(String)? onError}) {
    _userName = name;
    notifyListeners(); 
    if (onSuccess != null) onSuccess();
  }

  /// **📩 Request OTP**
  Future<void> requestOtp(
    int countryCode,
    int mobileNumber, {
    Function()? onSuccess,
    Function(String)? onError,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      await _apiService.createOtp(countryCode, mobileNumber);
      _countryCode = countryCode;
      _mobileNumber = mobileNumber;
      notifyListeners();

      if (onSuccess != null) onSuccess();
    } catch (e) {
      _handleError(e, onError);
    } finally {
      _setLoading(false);
    }
  }

  /// **🔐 Check If User Is Logged In**
  Future<void> checkLoginStatus(
    String cookie, {
    Function()? onSuccess,
    Function(String)? onError,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final userDetails = await _apiService.isLoggedIn(cookie);
      // debugPrint("loggedIn details: $userDetails");

      _csrfToken = userDetails['csrfToken'];
      _userData = UserModel.fromJson(userDetails['user']);
      _cookie = cookie;

      await TokenCache.saveCsrfToken(_csrfToken!);
      await UserCache.saveUserModel(_userData!);

      notifyListeners();
      if (onSuccess != null) onSuccess();
    } catch (e) {
      _csrfToken = null;
      _cookie = null;
      _userData = null;
      notifyListeners();
      _handleError(e, onError);
    } finally {
      _setLoading(false);
    }
  }

  /// **📲 Login with OTP**
  Future<void> login(
    int otp, {
    Function()? onSuccess,
    Function(String)? onError,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    if (_countryCode == null || _mobileNumber == null) {
      _handleError("Country code or mobile number is missing.", onError);
      return;
    }

    try {
      Map<String, dynamic> responseJson =
          await _apiService.validateOtp(_countryCode!, _mobileNumber!, otp);
      String cookie = responseJson['session'];
      // debugPrint("Session: $cookie");

      await TokenCache.saveAuthCookie(cookie);
      await checkLoginStatus(cookie, onSuccess: onSuccess, onError: onError);
    } catch (e) {
      _handleError(e, onError);
    } finally {
      _setLoading(false);
    }
  }

  /// **✏️ Update User Name**
  Future<void> updateUserName(
    String newUserName, {
    Function()? onSuccess,
    Function(String)? onError,
  }) async {
    if (_csrfToken == null) {
      _handleError("User is not logged in.", onError);
      return;
    }

    _setLoading(true);
    _errorMessage = null;

    try {
      await _apiService.updateUser(_countryCode!, newUserName, _csrfToken!, _cookie!);
      await checkLoginStatus(_cookie!);
      _userName = newUserName;
      notifyListeners();

      if (onSuccess != null) onSuccess();
    } catch (e) {
      _handleError(e, onError);
    } finally {
      _setLoading(false);
    }
  }

  /// **🚪 Logout**
  Future<void> logout({
    Function()? onSuccess,
    Function(String)? onError,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      await _apiService.logout(_csrfToken!, _cookie!);
      
      _csrfToken = null;
      _countryCode = null;
      _mobileNumber = null;
      _userName = null;
      _userData = null;
      _cookie = null;

      await TokenCache.deleteCsrfToken();
      await TokenCache.deleteAuthCookie();
      await UserCache.deleteUserModel();

      notifyListeners();
      if (onSuccess != null) onSuccess();
    } catch (e) {
      _handleError(e, onError);
    } finally {
      _setLoading(false);
    }
  }

  void setUserData({required UserModel userData}){
    _userData = userData;
    notifyListeners();
  }
}
