import 'package:flutter/material.dart';
import 'package:flutter_assignment_oru_phone_app/models/brand_model.dart';
import 'package:flutter_assignment_oru_phone_app/models/faq_model.dart';
import 'package:flutter_assignment_oru_phone_app/models/filter_model.dart';
import 'package:flutter_assignment_oru_phone_app/models/user_model.dart';
import '../services/api_service.dart';
import '../providers/user_auth_provider.dart';

class GeneralApiProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final UserAuthProvider _userAuthProvider;

  GeneralApiProvider(this._userAuthProvider);

  bool _isLoading = false;
  String? _errorMessage;
  List<Faq> _faqs = [];
  List<BrandDataObject> _brands = [];
  FilterData? _filterData;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Faq> get faqs => _faqs;
  List<BrandDataObject> get brands => _brands;
  FilterData? get filterData => _filterData;

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

  Future<void> fetchFaqs(
      {Function()? onSuccess, Function(String)? onError}) async {
    _setLoading(true);
    try {
      final response = await _apiService.fetchFaqs();
      // debugPrint("Response: $response");
      try {
        FaqResponse faqResponse = FaqResponse.fromJson(response);
        _faqs = faqResponse.faqs ?? [];
      } catch (e) {
        _handleError("Error decoding FAQs: $e", onError: onError);
        _faqs = [];
      }

      if (onSuccess != null) onSuccess();
    } catch (e) {
      // debugPrint("Error Ocurred: $e");
      _handleError(e, onError: onError);
      _faqs = [];
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchBrands(
      {Function()? onSuccess, Function(String)? onError}) async {
    _setLoading(true);
    try {
      final response = await _apiService.fetchBrands();
      BrandResponse brandResponse = BrandResponse.fromJson(response);
      _brands = brandResponse.dataObject;
      if (onSuccess != null) onSuccess();
    } catch (e) {
      _handleError(e, onError: onError);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchFilters(
      {Function()? onSuccess, Function(String)? onError}) async {
    _setLoading(true);
    try {
      final response = await _apiService.fetchFilters();
      try {
        FilterResponse filterResponse = FilterResponse.fromJson(response);
        _filterData = filterResponse.dataObject;
      } catch (e) {
        _handleError("Error decoding filters: $e", onError: onError);
        _filterData = null;
      }

      if (onSuccess != null) onSuccess();
    } catch (e) {
      _handleError(e, onError: onError);
      _filterData = null;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> likeProduct(String listingId, bool isFav,
      {Function()? onSuccess, Function(String)? onError}) async {
    _setLoading(true);
    try {
      String? csrfToken = _userAuthProvider.csrfToken;
      String? authCookie = _userAuthProvider.cookie;

      if (csrfToken == null || authCookie == null) {
        
        throw Exception("User is not authenticated");
      }

      UserModel userData = _userAuthProvider.userData!;
      if(isFav){
        userData.favListings.add(listingId);
      }else{
        userData.favListings.remove(listingId);
      }
      _userAuthProvider.setUserData(userData: userData);
      await _apiService.likeProduct(listingId, isFav, csrfToken, authCookie);
      if (onSuccess != null) onSuccess();
    } catch (e) {
      // debugPrint("Error occurred: $e");
      _handleError(e, onError: onError);
    } finally {
      _setLoading(false);
    }
  }
}
