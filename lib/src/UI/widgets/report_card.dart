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
  // final VoidCallback backToTaskPage;

  @override
  Widget build(BuildContext context) {
// Device height: 837.3333333333334
// Device width: 384.0
// Container width: 368.0, height: 261.0

    final String yesNo = wheelChair ? 'Yes' : 'No';

    final size = MediaQuery.of(context).size;

    final Color? color;

    if (status?.taskId == 0) {
      color = Colors.yellow.shade600;
    } else if (status?.taskId == 1) {
      color = Colors.green;
    } else if (status?.taskId == 4) {
      color = Colors.blue;
    } else {
      color = Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width - 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            border: Border.all(
              color: Colors.blue,
            )),
        child: ExpandablePanel(
          header: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task Name: $title',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
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
              ],
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
                Text(
                  'Start Location: $startLocation',
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Destination: $endLocation',
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Schedule Time: $date'),
                const SizedBox(
                  height: 10,
                ),
                Text('Is Wheel Chair Needed? : $yesNo'),
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
                // status?.taskId == 4
                //     ?  Padding(
                //         padding:
                //            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                //         child: AppButton(onPressed:backToTaskPage , label: 'Task Details',icon: Icons.,),
                //       )
                //     : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
