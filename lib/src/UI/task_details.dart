import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:porter_app/src/UI/home_screen.dart';
import 'package:porter_app/src/UI/widgets/app_button.dart';
import 'package:porter_app/src/data/porter.dart';
import 'package:porter_app/src/data/tasks.dart';

import '../repo/tasks.dart';
import 'task_screen.dart';

class TaskDetails extends ConsumerWidget {
  const TaskDetails({Key? key}) : super(key: key);

  static const routeName = '/taskDetails';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NotifPayload arguments =
        ModalRoute.of(context)?.settings.arguments as NotifPayload;

    // Porter dataForNotif = ModalRoute.of(context)?.settings.arguments as Porter;

    void _accepcted(int id, TaskData? data) async {
      if (data != null) {
        final payload = TaskPayload(
          id,
          data,
        );

        final repo = await ref.watch(taskUpdateProvider(payload).future);

        final dataPayload = DataPayload(data, arguments.porter);

        if (repo == true) {
          // Send to map page
          Navigator.of(context).pushNamed(
            TaskScreen.routeName,
            arguments: dataPayload,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error Occurred'),
            ),
          );
        }
      }
    }

    final tasks = arguments.data;
    final porter = arguments.porter;

    const _style = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Task Name: ${tasks.taskName}',
              style: _style,
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Start Location: ${tasks.startLocation}'),
            const SizedBox(
              height: 20,
            ),
            Text('End Location: ${tasks.destination}'),
            const SizedBox(
              height: 20,
            ),
            Text('Task Priority: ${tasks.priority}'),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppButton(
                  onPressed: () {
                    _accepcted(
                      tasks.taskId ?? 0,
                      TaskData(
                        tasks.taskName,
                        tasks.startLocation,
                        tasks.destination,
                        tasks.wheelChair,
                        tasks.scheduleDate,
                        tasks.taskId,
                        TaskStatus(
                          1,
                          'Accepted',
                          porter.userName,
                        ),
                        tasks.priority,
                        tasks.wheelChairType,
                        tasks.arriveTime,
                        DateFormat.yMd().add_Hms().format(DateTime.now()),
                        tasks.declineTime,
                        tasks.completeTime,
                        tasks.createdAt,
                      ),
                    );
                  },
                  label: 'Accept',
                  color: Colors.green,
                  icon: Icons.done,
                ),
                AppButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(HomeScreen.routeName);
                  },
                  label: 'Reject',
                  icon: Icons.close,
                  color: Colors.red,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
