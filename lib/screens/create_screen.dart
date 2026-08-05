import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:todo_ji/widgets/add_task_sheet.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: DraggableScrollableSheet(
          builder: (context, i) {
            return AddTaskSheet();
          },
        ),
      ),
    );
  }
}
