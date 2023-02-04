import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/employee_model.dart';
import 'package:mvvm/respository/home_repository.dart';

class HomeViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<EmployeeModel> empList = ApiResponse.loading();

  setEmpList(ApiResponse<EmployeeModel> response) {
    empList = response;
    notifyListeners();
  }

  Future<void> fetchEmployeeListApi() async {
    setEmpList(ApiResponse.loading());
    _myRepo.fetchEmpList().then((value) {
      setEmpList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setEmpList(ApiResponse.error(error.toString()));
    });
  }
}
