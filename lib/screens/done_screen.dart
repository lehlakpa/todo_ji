import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:todo_ji/models/task_models.dart';
import 'package:todo_ji/providers/task_providers.dart';
import 'package:todo_ji/widgets/delete_task_field.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final task = context.watch<TaskProviders>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Completed Tasks'),
                  GestureDetector(
                    onTap: () {
                      // context.read<TaskProviders>().deleteTask(context.read<TaskProviders>().deleteTask());
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<TaskProviders>().deleteall();
                      },
                      child: Text('Delete all'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  itemCount: task.doneTask.length,
                  itemBuilder: (context, index) =>
                      DeleteTaskField(task: task.doneTask[index]),
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
