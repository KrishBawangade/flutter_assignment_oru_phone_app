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
  void _handleError(dynamic e) {
    _errorMessage = e.toString().replaceFirst("Exception: ", "");
    notifyListeners();
  }

  /// **✏️ Set User Name**
  void setUserName(String name) {
    _userName = name;
    notifyListeners(); // ✅ Notify UI to update
  }

  /// **📩 Request OTP (Generate OTP)**
  Future<bool> requestOtp(int countryCode, int mobileNumber) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final response = await _apiService.createOtp(countryCode, mobileNumber);
      
      // ✅ Store country code and phone number
      _countryCode = countryCode;
      _mobileNumber = mobileNumber;

      notifyListeners();

      return response['success'] ?? true;
    } catch (e) {
      _handleError(e);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// **🔐 Check If User Is Logged In & Fetch CSRF Token**
  Future<void> checkLoginStatus(String cookie) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final userDetails = await _apiService.isLoggedIn(cookie);
      debugPrint("loggedIn details: $userDetails");
      _csrfToken = userDetails['csrfToken'];
      _userData = UserModel.fromJson(userDetails['user']); // ✅ Fetch & store user data
      debugPrint(" user data: ${userDetails['user']}");
      await TokenCache.saveCsrfToken(_csrfToken!);
      await UserCache.saveUserModel(_userData!);
    } catch (e) {
      _csrfToken = null;
      _cookie = null;
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  /// **📲 Login with OTP (Uses Stored Phone Details)**
  Future<bool> login(int otp) async {
    _setLoading(true);
    _errorMessage = null;

    if (_countryCode == null || _mobileNumber == null) {
      _handleError("Country code or mobile number is missing.");
      return false;
    }

    try {
      Map<String, dynamic> responseJson = await _apiService.validateOtp(_countryCode!, _mobileNumber!, otp);
      debugPrint("Session: $responseJson");
      String cookie = responseJson['session'];
      await TokenCache.saveAuthCookie(cookie);
      await checkLoginStatus(cookie); 
      return true;
    } catch (e) {
      _handleError(e);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// **✏️ Update User Name**
  Future<bool> updateUserName(String newUserName) async {
    if (_csrfToken == null) {
      _handleError("User is not logged in.");
      return false;
    }

    _setLoading(true);
    _errorMessage = null;

    try {
      await _apiService.updateUser(_countryCode!, newUserName, _csrfToken!);
      _userName = newUserName; // ✅ Update locally
      notifyListeners();
      return true;
    } catch (e) {
      _handleError(e);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// **🚪 Logout**
  Future<void> logout() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      await _apiService.logout(_csrfToken!);
      _csrfToken = null;
      _countryCode = null;
      _mobileNumber = null;
      _userName = null;
      _userData= null; // ✅ Clear user data
      await TokenCache.deleteCsrfToken();
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }
  
}
