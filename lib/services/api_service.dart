import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://40.90.224.241:5000";

  /// **🔹 Helper Function to Handle Errors & Extract Server Messages**
  Map<String, dynamic> _handleResponse(http.Response response,
      {bool returnCookie = false}) {
    try {
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (returnCookie) {
          // Extract session cookie from headers
          String? sessionCookie;
          if (response.headers.containsKey('set-cookie')) {
            String cookies = response.headers['set-cookie']!;
            List<String> cookieParts = cookies.split(';');
            for (var part in cookieParts) {
              if (part.trim().startsWith('session=')) {
                sessionCookie =
                    part.split('=')[1]; // Extract the session cookie value
                break;
              }
            }
          }
          // Add the session cookie to the response map
          decodedResponse['session'] = sessionCookie ?? "";
        }
        return decodedResponse;
      } else {
        throw Exception(decodedResponse['error'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      throw Exception('Failed to parse response: $e');
    }
  }

  /// **📲 Create OTP**
  Future<Map<String, dynamic>> createOtp(
      int countryCode, int mobileNumber) async {
    final url = Uri.parse('$baseUrl/login/otpCreate');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'countryCode': countryCode,
        'mobileNumber': mobileNumber,
      }),
    );
    return _handleResponse(response);
  }

  /// **✅ Validate OTP**
  Future<Map<String, dynamic>> validateOtp(
      int countryCode, int mobileNumber, int otp) async {
    final url = Uri.parse('$baseUrl/login/otpValidate');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'countryCode': countryCode,
        'mobileNumber': mobileNumber,
        'otp': otp,
      }),
    );
    return _handleResponse(response, returnCookie: true);
  }

  /// **🔐 Check If User Is Logged In**
  Future<Map<String, dynamic>> isLoggedIn(String authCookie) async {
    final url = Uri.parse('$baseUrl/isLoggedIn');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': authCookie,
      },
    );
    return _handleResponse(response);
  }

  /// **🚪 Logout**
  Future<void> logout(String authCookie) async {
    final url = Uri.parse('$baseUrl/logout');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': authCookie,
      },
    );
    _handleResponse(response);
  }

  /// **👤 Update User Details**
  Future<void> updateUser(
      int countryCode, String userName, String csrfToken) async {
    final url = Uri.parse('$baseUrl/update');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Csrf-Token': csrfToken,
      },
      body: jsonEncode({
        'countryCode': countryCode,
        'userName': userName,
      }),
    );
    _handleResponse(response);
  }

  /// **❓ Fetch FAQs**
  Future<List<dynamic>> fetchFaqs() async {
    final url = Uri.parse('$baseUrl/faq');
    final response = await http.get(url);
    return _handleResponse(response)['faqs'] ?? [];
  }

  /// **🛒 Fetch Products with Filters**
  Future<List<dynamic>> fetchProducts(Map<String, dynamic> filters) async {
    final url = Uri.parse('$baseUrl/filter');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'filter': filters}),
    );
    return _handleResponse(response)['products'] ?? [];
  }

  /// **❤️ Like/Unlike Product**
  Future<void> likeProduct(
      String listingId, bool isFav, String csrfToken) async {
    final url = Uri.parse('$baseUrl/favs');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Csrf-Token': csrfToken,
      },
      body: jsonEncode({
        'listingId': listingId,
        'isFav': isFav,
      }),
    );
    _handleResponse(response);
  }

  /// **🏢 Fetch Brands with Images**
  Future<List<dynamic>> fetchBrands() async {
    final url = Uri.parse('$baseUrl/makeWithImages');
    final response = await http.get(url);
    return _handleResponse(response)['brands'] ?? [];
  }

  /// **🔍 Fetch Search Filters**
  Future<Map<String, dynamic>> fetchFilters() async {
    final url = Uri.parse('$baseUrl/showSearchFilters');
    final response = await http.get(url);
    return _handleResponse(response);
  }
}
