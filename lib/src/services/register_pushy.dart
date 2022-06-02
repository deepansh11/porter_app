import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:porter_app/src/UI/login.dart';
import 'package:porter_app/src/UI/task_details.dart';
import 'package:porter_app/src/UI/welcome.dart';
import 'package:porter_app/src/data/tasks.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

import '../data/porter.dart';

class PushyRepository {
  Future pushyRegister() async {
    try {
      // Register the user for push notifications
      String deviceToken = await Pushy.register();

      // Print token to console/logcat
      print('Device token: $deviceToken');

      // Display an alert with the device token

      // Optionally send the token to your backend server via an HTTP GET request
      // ...
    } on PlatformException catch (error) {
      // Display an alert with the error message
      print(error);
    }
  }

  void sendToTaskScreen(BuildContext context, Porter? porterData) {
    Pushy.setNotificationClickListener((Map<String, dynamic> data) {
      print('Notification click: $data');

      final taskData = TaskDataForNotif.fromJson(data);

      if (porterData != null) {
        Navigator.of(context).pushNamed(
          TaskDetails.routeName,
          arguments: NotifPayload(taskData, porterData),
        );
      } else {
        Navigator.of(context).pushNamed(WelcomePage.routeName);
      }

      // Clear iOS app badge number
      Pushy.clearBadge();
    });
  }
}
