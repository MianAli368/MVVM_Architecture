import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/respository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _signUploading = false;
  bool get signUploading => _signUploading;

  setsignUploading(bool value) {
    _signUploading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginFunc(data).then((value) {
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(UserModel(token: value['token'].toString()));
      print("Token : ${value['token'].toString()}");
      Utils.flushBarErrorMsg("Login Successfully", context);
      setLoading(false);
      if (kDebugMode) {
        // Navigator.pushNamed(context, RoutesName.home);
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMsg("Oops! Something went wrong", context);
      setLoading(false);
      if (kDebugMode) {
        // Utils.flushBarErrorMsg(error.toString(), context);

        print(error.toString());
      }
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setsignUploading(true);
    _myRepo.registerFunc(data).then((value) {
      setsignUploading(false);

      Utils.flushBarErrorMsg("Sign Up Successfully", context);
      if (kDebugMode) {
        // Navigator.pushNamed(context, RoutesName.home);
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMsg("Oops! Something went wrong", context);
      setsignUploading(false);
      if (kDebugMode) {
        // Utils.flushBarErrorMsg(error.toString(), context);

        print(error.toString());
      }
    });
  }
}
