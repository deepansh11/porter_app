import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:porter_app/src/UI/home.dart';
import 'package:porter_app/src/data/porter.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

import '../UI/home_screen.dart';

class AuthenticationRepository {
  AuthenticationRepository();

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://warm-eyrie-19537.herokuapp.com/',
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Origin,Content-Type",
        "Access-Control-Allow-Methods": "GET,POST,HEAD,OPTIONS,PUT,DELETE"
      },
      connectTimeout: 60 * 1000,
    ),
  );

  void showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> register(Porter porter, BuildContext context) async {
    try {
      // final client = AuthenticationService(dio, baseUrl: baseUrl);

      final response = await dio.post('/register', data: porter.toJson());
      print(response);

      if (response.statusCode == 200) {
        if (response.toString() == 'User already exists') {
          await EasyLoading.showError(
            response.toString(),
          );
        } else {
          showLoaderDialog(context);

          await EasyLoading.showSuccess(
            response.toString(),
          );

          Navigator.of(context).pushReplacementNamed(
            HomeScreen.routeName,
            arguments: porter,
          );
          String? deviceToken = await Pushy.register();

          print('Device Token: $deviceToken');

          if (deviceToken.isNotEmpty) {
            await Pushy.subscribe('tasks');
          }
        }
      } else {
        await EasyLoading.showError(
            "Server not responding, Please try again later");
      }
    } catch (e, s) {
      print('Error in sending register data: $e, $s');
    }
  }

  void login(Porter porter, BuildContext context) async {
    try {
      final response = await dio.post(
        '/login',
        data: porter.toJson(),
      );

      if (response.statusCode == 200) {
        if (response.toString() == 'Wrong Credentials') {
          await EasyLoading.showError(response.toString());
        } else {
          showLoaderDialog(context);

          await EasyLoading.showSuccess(
            response.toString(),
          );

          Navigator.of(context).pushReplacementNamed(
            HomeScreen.routeName,
            arguments: porter,
          );
          String? deviceToken = await Pushy.register();

          print('Device Token: $deviceToken');

          if (deviceToken.isNotEmpty) {
            await Pushy.subscribe('tasks');
          }
        }
      } else {
        await EasyLoading.showError(
            "Server not responding, Please try again later");
      }
    } catch (e, s) {
      print('Error in sending register data: $e, $s');
    }
  }
}
