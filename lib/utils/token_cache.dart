import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenCache {
  static const _storage = FlutterSecureStorage();
  static const _csrfTokenKey = 'csrf_token';
  static const _authCookieKey = 'auth_cookie';

  // Save CSRF token to secure storage
  static Future<void> saveCsrfToken(String token) async {
    await _storage.write(key: _csrfTokenKey, value: token);
  }

  // Get CSRF token from secure storage
  static Future<String?> getCsrfToken() async {
    return await _storage.read(key: _csrfTokenKey);
  }

  // Delete CSRF token from secure storage
  static Future<void> deleteCsrfToken() async {
    await _storage.delete(key: _csrfTokenKey);
  }

  // Save Auth Cookie to secure storage
  static Future<void> saveAuthCookie(String cookie) async {
    await _storage.write(key: _authCookieKey, value: cookie);
  }

  // Get Auth Cookie from secure storage
  static Future<String?> getAuthCookie() async {
    return await _storage.read(key: _authCookieKey);
  }

  // Delete Auth Cookie from secure storage
  static Future<void> deleteAuthCookie() async {
    await _storage.delete(key: _authCookieKey);
  }
}
