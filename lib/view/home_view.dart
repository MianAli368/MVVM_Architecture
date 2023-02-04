import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/resources/components/round_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    homeViewModel.fetchEmployeeListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
            actions: [
              TextButton(
                  // style: TextButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: () {
                    userPreferences.removeUser().then((value) {
                      Navigator.pushNamed(context, RoutesName.login);
                    });
                  },
                  child: const Text(
                    "Log Out",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          body: ChangeNotifierProvider<HomeViewModel>(
            create: (BuildContext context) => homeViewModel,
            child: Consumer<HomeViewModel>(
              builder: (context, value, child) {
                switch (value.empList.status) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Center(
                        child: Text(value.empList.message.toString()));
                  case Status.COMPLETED:
                    return ListView.builder(
                        itemCount: value.empList.data!.data!.length,
                        itemBuilder: ((context, index) {
                          return Card(
                            child: ListTile(
                                title: Text(
                                    "${value.empList.data!.data![index].employeeName}"),
                                subtitle: Text(
                                    "${value.empList.data!.data![index].employeeSalary}"),
                                trailing: Text(
                                    "${value.empList.data!.data![index].id}")),
                          );
                        }));
                }
                return Container();
              },
            ),
          )),
    );
  }
}
