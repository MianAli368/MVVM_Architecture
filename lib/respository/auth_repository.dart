import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/resources/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  // Login Function
  Future<dynamic> loginFunc(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
          return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> registerFunc(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.registerUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
