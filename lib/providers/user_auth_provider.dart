import 'package:flutter/material.dart';
import 'package:flutter_assignment_oru_phone_app/services/api_service.dart';
import 'package:flutter_assignment_oru_phone_app/utils/token_cache.dart';

class UserAuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  String? _csrfToken;
  bool _isLoading = false;

  String? get csrfToken => _csrfToken;
  bool get isLoading => _isLoading;

  // Check if the user is logged in and fetch the CSRF token
  Future<void> checkLoginStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Fetch the token from cache
      _csrfToken = await TokenCache.getCsrfToken();

      if (_csrfToken != null) {
        // Validate the token by calling isLoggedIn
        final userDetails = await _apiService.isLoggedIn(_csrfToken!);
        _csrfToken = userDetails['csrfToken']; // Update token if needed
        await TokenCache.saveCsrfToken(_csrfToken!);
      }
    } catch (e) {
      // Token is invalid, clear it from cache
      _csrfToken = null;
      await TokenCache.deleteCsrfToken();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login with OTP
  Future<void> login(int countryCode, int mobileNumber, int otp) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.validateOtp(countryCode, mobileNumber, otp);
      await checkLoginStatus(); // Fetch and cache the CSRF token
    } catch (e) {
      throw Exception('Login failed: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.logout(_csrfToken!);
      _csrfToken = null;
      await TokenCache.deleteCsrfToken();
    } catch (e) {
      throw Exception('Logout failed: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}