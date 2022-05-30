import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:porter_app/src/UI/widgets/app_button.dart';
import 'package:porter_app/src/data/tasks.dart';

class ReportsCard extends StatelessWidget {
  const ReportsCard({
    Key? key,
    this.title,
    this.startLocation,
    this.endLocation,
    this.id,
    required this.date,
    required this.wheelChair,
    required this.accepted,
    required this.rejected,
    this.status,
  }) : super(key: key);

  final String? title;

  final String? startLocation;
  final String? endLocation;
  final String? id;
  final String? date;
  final TaskStatus? status;
  final bool wheelChair;
  final VoidCallback accepted;
  final VoidCallback rejected;

  @override
  Widget build(BuildContext context) {
    final String yesNo = wheelChair ? 'Yes' : 'No';

    Color? color;

    if (status?.taskId == 0) {
      color = Colors.yellow.shade600;
    } else if (status?.taskId == 1) {
      color = Colors.green;
    } else {
      color = Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: Colors.blue,
            )),
        child: ExpandablePanel(
          header: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Task Name: $title',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          collapsed: const SizedBox(),
          expanded: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Task ID: $id',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Start Location: $startLocation'),
                    Text('Destination: $endLocation'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Schedule Time: $date'),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                              child: Container(
                            padding: const EdgeInsets.all(4),
                            child: const Text('Task Status: '),
                          )),
                          WidgetSpan(
                            child: Container(
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                status?.taskStatus.toString() ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text('Is Wheel Chair Needed? : $yesNo'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                status?.taskId == 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppButton(
                              onPressed: accepted,
                              label: 'Accept',
                              icon: Icons.done,
                              color: Colors.green,
                            ),
                            AppButton(
                              onPressed: rejected,
                              label: 'Reject',
                              icon: Icons.close,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
