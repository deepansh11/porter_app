import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:porter_app/src/UI/task_screen.dart';
import 'package:porter_app/src/data/porter.dart';
import 'package:porter_app/src/data/tasks.dart';
import 'package:porter_app/src/repo/providers.dart';
import 'package:porter_app/src/repo/tasks.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

import 'widgets/report_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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

  void _accepcted(int id, TaskData? data) async {
    if (data != null) {
      final payload = TaskPayload(id, data);

      final repo = await ref.watch(taskUpdateProvider(payload).future);

      if (repo == true) {
        // Send to map page
        Navigator.of(context).pushNamed(
          TaskScreen.routeName,
          arguments: data,
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Error Occurred')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Porter arguments = ModalRoute.of(context)?.settings.arguments as Porter;

    final list = ref.watch(taskFetchProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Reports'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: _pullToRefresh,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              list.when(data: (data) {
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final tasks = data?.data?.elementAt(index);
                      final id = tasks?.taskId ?? 0;
                      final title = tasks?.taskName;
                      final wheelChair = tasks?.wheelChair ?? false;
                      final start = tasks?.startLocation;
                      final end = tasks?.destination;
                      final date = tasks?.scheduleDate;
                      final taskStatus = tasks?.taskStatus;

                      final newTask = TaskData(
                        title,
                        start,
                        end,
                        wheelChair,
                        date,
                        id,
                        TaskStatus(1, 'accepted', arguments.userName),
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
      ),
    );
  }
}
