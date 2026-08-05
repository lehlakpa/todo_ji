import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_ji/models/task_models.dart';
import 'package:todo_ji/providers/task_providers.dart';

class DeleteTaskField extends StatelessWidget {
  final TaskModels task;
  const DeleteTaskField({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    // final tasks = context.watch<TaskProviders>().allTasks;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.blueGrey,
      ),
      child: Row(
        children: [
          // Checkbox(
          //   value: true,
          //   side: BorderSide(color: Colors.grey, width: 2),
          //   onChanged: (val) {},
          // ),
          SizedBox(width: 16),
          Text(task.title),
          Spacer(),
          GestureDetector(
            onTap: () {
              context.read<TaskProviders>().deleteTask(task.id);
            },
            child: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
