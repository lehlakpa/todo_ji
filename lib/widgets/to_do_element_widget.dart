import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_ji/models/task_models.dart';
import 'package:todo_ji/providers/task_providers.dart';

class ToDoElementWidget extends StatelessWidget {
  const ToDoElementWidget({required this.task, super.key});
  final TaskModels task;
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProviders>();
    return ExpansionTile(
      expandedCrossAxisAlignment: CrossAxisAlignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      collapsedBackgroundColor: const Color.fromARGB(255, 226, 223, 223),
      backgroundColor: const Color.fromARGB(255, 236, 218, 218),
      childrenPadding: EdgeInsets.only(left: 60, top: 10, bottom: 10),
      leading: Checkbox(
        value: task.isdone,
        side: BorderSide(color: Colors.grey, width: 2),
        onChanged: (val) {
          provider.updateWork(task.id, val!);
        },
      ),
      title: Text(task.title),
      showTrailingIcon: false,
      children: [Text(task.description)],
    );
  }
}
