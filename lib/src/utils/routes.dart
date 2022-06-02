import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:porter_app/src/UI/home.dart';
import 'package:porter_app/src/UI/login.dart';
import 'package:porter_app/src/UI/register.dart';
import 'package:porter_app/src/UI/task_details.dart';
import 'package:porter_app/src/UI/task_screen.dart';
import 'package:porter_app/src/UI/welcome.dart';
import 'package:porter_app/src/data/porter.dart';

import '../UI/home_screen.dart';

final routesProvider = Provider((ref) {
  return Routes();
});

final routesRepo = Provider(
  (ref) {
    final repo = ref.read(routesProvider);
    return repo.routesMap;
  },
);

class Routes {
  final routesMap = {
    WelcomePage.routeName: (BuildContext context) => const WelcomePage(),
    RegisterPage.routeName: (BuildContext context) => const RegisterPage(),
    LoginPage.routeName: (BuildContext context) => const LoginPage(),
    HomeScreen.routeName: (BuildContext context) => const HomeScreen(),
    TaskScreen.routeName: (BuildContext context) => const TaskScreen(),
    TaskDetails.routeName: (BuildContext context) => const TaskDetails(),
  };
}
