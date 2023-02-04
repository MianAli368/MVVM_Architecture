import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/model/employee_model.dart';
import 'package:mvvm/resources/app_url.dart';

class HomeRepository {
  BaseApiServices _apiServices = NetworkApiService();
  Future<EmployeeModel> fetchEmpList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.EmpListUrl);
      return response = EmployeeModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
