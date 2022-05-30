import 'package:flutter/material.dart';
import 'package:porter_app/src/data/tasks.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);
  static const routeName = '/taskInfo';

  @override
  Widget build(BuildContext context) {
    TaskData taskData = ModalRoute.of(context)?.settings.arguments as TaskData;
    return Scaffold(
      appBar: AppBar(
        title: Text(taskData.taskName.toString()),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Start location: ${taskData.startLocation}',
            ),
            Text(
              'End location: ${taskData.destination}',
            ),
          ],
        ),
      ),
    );
  }
}
