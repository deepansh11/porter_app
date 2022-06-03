import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:porter_app/main.dart';
import 'package:porter_app/src/UI/task_screen.dart';
import 'package:porter_app/src/data/porter.dart';
import 'package:porter_app/src/data/tasks.dart';
import 'package:porter_app/src/repo/tasks.dart';
import 'package:porter_app/src/services/mqtt_to_stream.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

import '../repo/providers.dart';
import 'widgets/report_card.dart';

class TaskDataScreen extends ConsumerStatefulWidget {
  const TaskDataScreen(this.porter, {Key? key}) : super(key: key);
  final Porter porter;

  @override
  ConsumerState<TaskDataScreen> createState() => _TaskDataScreenState();
}

class _TaskDataScreenState extends ConsumerState<TaskDataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() async {
      ref.watch(taskFetchProvider);
    });
  }

  Future<void> _pullToRefresh() {
    return Future.microtask(() => ref.refresh(taskFetchProvider));
  }

  void _accepcted(int id, TaskData? data, Porter porter) async {
    if (data != null) {
      final payload = TaskPayload(
        id,
        data,
      );

      final dataPayload = DataPayload(data, porter);

      final repo = await ref.watch(taskUpdateProvider(payload).future);

      if (repo == true) {
        // Send to map page
        Navigator.of(context).pushNamed(
          TaskScreen.routeName,
          arguments: dataPayload,
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Error Occurred')));
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(taskFetchProvider);

    return RefreshIndicator(
      onRefresh: _pullToRefresh,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            list.when(data: (data) {
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final itemCount = data?.data?.length ?? 0;
                    int reversedIndex = itemCount - 1 - index;
                    final tasks = data?.data?.elementAt(reversedIndex);
                    final id = tasks?.taskId ?? 0;
                    final title = tasks?.taskName;
                    final wheelChair = tasks?.wheelChair ?? false;
                    final start = tasks?.startLocation;
                    final end = tasks?.destination;
                    final date = tasks?.scheduleDate;
                    final taskStatus = tasks?.taskStatus;
                    final priority = tasks?.priority;
                    final wheelChairType = tasks?.wheelChairType;
                    final completeTime = tasks?.completeTime;
                    final arriveTime = tasks?.arriveTime;
                    final endTime = tasks?.declineTime;
                    final createdAt = tasks?.createdAt;

                    final newTask = TaskData(
                      title,
                      start,
                      end,
                      wheelChair,
                      date,
                      id,
                      TaskStatus(1, 'Accepted', widget.porter.userName),
                      priority,
                      wheelChairType,
                      arriveTime,
                      DateFormat.yMd().add_Hms().format(DateTime.now()),
                      endTime,
                      completeTime,
                      createdAt,
                    );

                    return ReportsCard(
                      title: title,
                      id: id.toString(),
                      startLocation: start,
                      endLocation: end,
                      date: date ??
                          DateFormat.yMd().add_Hms().format(DateTime.now()),
                      wheelChair: wheelChair,
                      accepted: () => _accepcted(
                        id,
                        newTask,
                        widget.porter,
                      ),
                      rejected: () {},
                      status: taskStatus,
                    );
                  },
                  itemCount: data?.data?.length ?? 0,
                ),
              );
            }, error: (e, s) {
              print('Error: $e $s');
              return const Center(
                child: Text('Error Can\'t load data at the moment'),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
