import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

import 'src/utils/routes.dart';

void backgroundNotificationListener(Map<String, dynamic> data) {
  // Print notification payload data
  print('Received notification: $data');

  // Notification title
  String notificationTitle = 'New Task Added!';
  String name = data['taskName'];
  String startLocation = data['startLocation'];
  String endLocation = data['destination'];

  // Attempt to extract the "message" property from the payload: {"message":"Hello World!"}
  String notificationText =
      'Task name: $name with $startLocation and $endLocation';

  // Android: Displays a system notification
  // iOS: Displays an alert dialog
  Pushy.notify(notificationTitle, notificationText, data);

  // Clear iOS app badge number
  Pushy.clearBadge();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routes = ref.read(routesRepo);

    return MaterialApp(
      title: 'Porter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}
