import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/token_cache.dart';

class UserAuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  String? _csrfToken;
  bool _isLoading = false;
  String? _errorMessage; // ✅ Store error message

  String? get csrfToken => _csrfToken;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage; // ✅ Expose error message

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

  /// **📩 Request OTP (Generate OTP)**
  Future<bool> requestOtp(int countryCode, int mobileNumber) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final response = await _apiService.createOtp(countryCode, mobileNumber);
      return response['success'] ?? true; // ✅ Return success flag
    } catch (e) {
      _handleError(e);
      return false; // ❌ Return failure
    } finally {
      _setLoading(false);
    }
  }

  /// **🔐 Check If User Is Logged In & Fetch CSRF Token**
  Future<void> checkLoginStatus() async {
    _setLoading(true);
    _errorMessage = null; // ✅ Reset error message

    try {
      _csrfToken = await TokenCache.getCsrfToken();

      if (_csrfToken != null) {
        final userDetails = await _apiService.isLoggedIn(_csrfToken!);
        _csrfToken = userDetails['csrfToken']; // Update token if needed
        await TokenCache.saveCsrfToken(_csrfToken!);
      }
    } catch (e) {
      _csrfToken = null;
      await TokenCache.deleteCsrfToken();
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  /// **📲 Login with OTP**
  Future<bool> login(int countryCode, int mobileNumber, int otp) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      await _apiService.validateOtp(countryCode, mobileNumber, otp);
      await checkLoginStatus(); // ✅ Fetch and cache CSRF token
      return true; // ✅ Login success
    } catch (e) {
      _handleError(e);
      return false; // ❌ Login failed
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
      await TokenCache.deleteCsrfToken();
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }
}
