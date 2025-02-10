import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://40.90.224.241:5000";

  // Function to create OTP
  Future<Map<String, dynamic>> createOtp(int countryCode, int mobileNumber) async {
    final url = Uri.parse('$baseUrl/login/otpCreate');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'countryCode': countryCode,
        'mobileNumber': mobileNumber,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create OTP');
    }
  }

  // Function to validate OTP
  Future<Map<String, dynamic>> validateOtp(int countryCode, int mobileNumber, int otp) async {
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

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to validate OTP');
    }
  }

  // Function to check if the user is logged in and fetch user details
  Future<Map<String, dynamic>> isLoggedIn(String csrfToken) async {
    final url = Uri.parse('$baseUrl/isLoggedIn');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Csrf-Token': csrfToken,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user details');
    }
  }

  // Function to logout
  Future<void> logout(String csrfToken) async {
    final url = Uri.parse('$baseUrl/logout');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Csrf-Token': csrfToken,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to logout');
    }
  }

  // Function to update user details
  Future<void> updateUser(int countryCode, String userName, String csrfToken) async {
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

    if (response.statusCode != 200) {
      throw Exception('Failed to update user details');
    }
  }

  // Function to fetch FAQs
  Future<List<dynamic>> fetchFaqs() async {
    final url = Uri.parse('$baseUrl/faq');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch FAQs');
    }
  }

  // Function to fetch products with filters
  Future<List<dynamic>> fetchProducts(Map<String, dynamic> filters) async {
    final url = Uri.parse('$baseUrl/filter');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'filter': filters}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  // Function to like/unlike a product
  Future<void> likeProduct(String listingId, bool isFav, String csrfToken) async {
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

    if (response.statusCode != 200) {
      throw Exception('Failed to like/unlike product');
    }
  }

  // Function to fetch brands with images
  Future<List<dynamic>> fetchBrands() async {
    final url = Uri.parse('$baseUrl/makeWithImages');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch brands');
    }
  }

  // Function to fetch search filters
  Future<Map<String, dynamic>> fetchFilters() async {
    final url = Uri.parse('$baseUrl/showSearchFilters');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch filters');
    }
  }
}