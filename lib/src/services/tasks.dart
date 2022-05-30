import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:porter_app/src/data/tasks.dart';

class TasksRepository {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://warm-eyrie-19537.herokuapp.com/',
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Origin,Content-Type",
        "Access-Control-Allow-Methods": "GET,POST,HEAD,OPTIONS,PUT,DELETE"
      },
      connectTimeout: 60 * 100,
    ),
  );

  Future<TaskResponse?> getTask() async {
    TaskResponse? data;

    try {
      Response taskData = await dio.get(
        '/task',
      );

      final json = taskData.data;
      final tasks = TaskResponse.fromJson(json);
      data = tasks;
      // print(data.data?.first?.taskStatus);
    } catch (e, s) {
      print('Error while fetching task: $e $s');
    }
    return data;
  }

  Future<bool?> updateTask(int taskId, TaskData data) async {
    try {
      Response task = await dio.put('/task' + '/$taskId', data: data.toJson());

      if (task.statusCode == 200) {
        if (task.toString() == 'Task updated successfully') {
          await EasyLoading.showSuccess('You have accepted the task');
        } else {
          await EasyLoading.showError('Error occurred please try again later');
        }
      }
      return true;
    } catch (e, s) {
      print('Error while updating task data: $e $s');
      return false;
    }
  }
}
