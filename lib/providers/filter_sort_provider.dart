import 'package:flutter/material.dart';
import 'package:flutter_assignment_oru_phone_app/models/product_model.dart';
import '../services/api_service.dart';

class FilterSortProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  Map<String, dynamic> _appliedFilters = {};
  String _sortOption = "";
  bool _isLoading = false;
  String? _errorMessage;
  List<Product> _filteredProducts = []; // Store filtered products as List<Product>

  Map<String, dynamic> get appliedFilters => _appliedFilters;
  String get sortOption => _sortOption;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Product> get filteredProducts => _filteredProducts; // Correct getter type

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _handleError(dynamic e, {Function(String)? onError}) {
    _errorMessage = e.toString().replaceFirst("Exception: ", "");
    notifyListeners();
    if (onError != null) {
      onError(_errorMessage!);
    }
  }

  void setFilters(Map<String, dynamic> filters) {
    _appliedFilters = filters;
    notifyListeners();
  }

  void setSortOption(String sort) {
    _sortOption = sort;
    notifyListeners();
  }

  void setFilteredProducts(List<Product> filteredProducts){
    _filteredProducts = filteredProducts;
    notifyListeners();
  }

  Future<void> fetchFilteredProducts({Function()? onSuccess, Function(String)? onError}) async {
    _setLoading(true);
    try {
      final response = await _apiService.fetchProducts(_appliedFilters);
      // debugPrint("Response product: $response");

      try {
        ProductResponse productResponse = ProductResponse.fromJson(response);
        _filteredProducts = productResponse.data?.data ?? []; // Extract the List<Product>
      } catch (e) {
        _handleError("Error decoding products: $e", onError: onError);
        _filteredProducts = [];
      }
    
      if (onSuccess != null) onSuccess();
    } catch (e) {
      // debugPrint("Error occurred: $e");
      _handleError(e, onError: onError);
      _filteredProducts = [];
    } finally {
      _setLoading(false);
    }
  }
}