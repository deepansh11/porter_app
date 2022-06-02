import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:porter_app/src/data/tasks.dart';
import 'package:porter_app/src/services/tasks.dart';

final dioClientProvider = Provider((ref) {
  return TasksRepository();
});

final taskFetchProvider = FutureProvider((ref) {
  final repo = ref.watch(dioClientProvider);

  return repo.getTask();
});

final taskUpdateProvider =
    FutureProvider.family.autoDispose((ref, TaskPayload payload) {
  final repo = ref.watch(dioClientProvider);

  return repo.updateTask(payload.taskId, payload.data);
});

class TaskPayload {
  final int taskId;
  final TaskData data;
  // final String startTime;

  TaskPayload(
    this.taskId,
    this.data,
  );
}
