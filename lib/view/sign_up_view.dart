import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mvvm/resources/components/round_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController eContr = TextEditingController();
  TextEditingController pContr = TextEditingController();

  FocusNode emailFN = FocusNode();
  FocusNode passFN = FocusNode();

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    super.dispose();
    eContr.dispose();
    pContr.dispose();
    emailFN.dispose();
    passFN.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: eContr,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFN,
                decoration: const InputDecoration(
                    hintText: "Email",
                    labelText: "Email",
                    prefixIcon: Icon(Icons.alternate_email)),
                onFieldSubmitted: (val) {
                  Utils.fieldFocusChange(context, emailFN, passFN);
                },
              ),
              ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: ((context, value, child) {
                    return TextFormField(
                      controller: pContr,
                      obscureText: _obsecurePassword.value,
                      focusNode: passFN,
                      decoration: InputDecoration(
                          hintText: "Password",
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: InkWell(
                            child: _obsecurePassword.value
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off_outlined),
                            onTap: () {
                              _obsecurePassword.value =
                                  !_obsecurePassword.value;
                            },
                          )),
                    );
                  })),
              SizedBox(
                height: height * .1,
              ),
              RoundButton(
                  title: "Login",
                  loading: authViewModel.signUploading,
                  onPress: () {
                    if (eContr.text.isEmpty) {
                      Utils.flushBarErrorMsg("Please Enter Email", context);
                    } else if (pContr.text.isEmpty) {
                      Utils.flushBarErrorMsg("Please Enter Password", context);
                    } else if (pContr.text.length < 6) {
                      Utils.flushBarErrorMsg(
                          "Password length should be atleast 6", context);
                    } else {
                      print("Api hit");
                      Map data = {
                        // "email": eContr.text.toString(),
                        // "password": pContr.text.toString()
                        "email": eContr.text,
                        "password": pContr.text
                        // "email": "eve.holt@reqres.in",
                        // "password": "cityslicka"
                      };
                      authViewModel.signUpApi(data, context);

                      Navigator.pushNamed(context, RoutesName.home);

                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RoutesName.login);
                          },
                          child: const Text("Already have an Account ? Login"));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
