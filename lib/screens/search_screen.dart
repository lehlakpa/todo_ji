import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_ji/providers/task_providers.dart';
import 'package:todo_ji/widgets/to_do_element_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // 1. Declare the controller to manage text input
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    // 2. Clean up the controller when the widget is disposed
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 3. Watch the filtered search results list from your provider
    final searchedTasks = context.watch<TaskProviders>().searchedTasks;
    final isQueryEmpty = _searchController.text.trim().isEmpty;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController, // 4. Link the controller
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search tasks',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
                // 5. Use onChanged to filter instantly as the user types
                // Use context.read in callbacks (not watch) to avoid rebuilds
                onChanged: (value) {
                  context.read<TaskProviders>().searchTask(searchText: value);
                },
              ),
              const SizedBox(height: 32),
              Expanded(
                // 6. Only build the list if there are items to show
                child: searchedTasks.isEmpty
                    ? Center(
                        child: Text(
                          isQueryEmpty
                              ? 'Start typing to search...'
                              : 'No tasks found',
                        ),
                      )
                    : ListView.separated(
                        itemCount:
                            searchedTasks.length, // 7. Use dynamic length
                        separatorBuilder: (_, _) => const SizedBox(
                          height: 12,
                        ), // 8. Use for spacing only
                        itemBuilder: (context, index) {
                          // 9. Build your UI components here
                          return ToDoElementWidget(task: searchedTasks[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
