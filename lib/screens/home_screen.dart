import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_ji/providers/task_providers.dart';
import '../widgets/to_do_element_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Welcome, '),
                    TextSpan(text: 'John'),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text(
                'You’ve got ${context.watch<TaskProviders>().allTasks.length} tasks to do.',
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  itemCount: context.watch<TaskProviders>().allTasks.length,
                  separatorBuilder: (_, index) {
                    return SizedBox(height: 20);
                  },
                  itemBuilder: (context, index) {
                    return ToDoElementWidget(
                      task: context.watch<TaskProviders>().allTasks[index],
                      // task: context.watch<TaskProviders>().allTasks[index],
                    );
                  },
                ),
                // ListView(
                //   children: [
                //     ToDoElementWidget(task: allTasks[0]),
                //     SizedBox(height: 12),
                //     ToDoElementWidget(task: allTasks[1]),
                //     SizedBox(height: 12),
                //     ToDoElementWidget(task: allTasks[2]),
                //     SizedBox(height: 12),
                //     ToDoElementWidget(task: allTasks[3]),
                //     SizedBox(height: 12),
                //     ToDoElementWidget(task: allTasks[4]),
                //     // TodoElementWidget(
                //     //   title: 'Finish weather app',
                //     //   // description: 'This task must be done by Sunday',
                //     // ),
                //     // SizedBox(height: 12),
                //     // TodoElementWidget(
                //     //   title: 'Visit doctor',
                //     //   description: 'Visit doctor on time',
                //     // ),
                //     // SizedBox(height: 12),
                //     // TodoElementWidget(
                //     //   title: 'Get the work done',
                //     //   description:
                //     //       'This task should be done by tomorrow. This is awesome.',
                //     // ),
                //     SizedBox(height: 12),
                //   ],
                // ),
              ),

              // Expanded(
              //   child: ListView(
              //     children: [
              //       TodoElementWidget(),
              //       SizedBox(height: 12),
              //       TodoElementWidget(),
              //       SizedBox(height: 12),
              //       TodoElementWidget(),
              //       SizedBox(height: 12),
              //       TodoElementWidget(),
              //       SizedBox(height: 12),
              //       TodoElementWidget(),
              //       SizedBox(height: 12),
              //       TodoElementWidget(),
              //       SizedBox(height: 12),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
