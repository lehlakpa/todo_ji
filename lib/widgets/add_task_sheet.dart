import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_ji/providers/task_providers.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _titleController = TextEditingController();

  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //Title
            TextFormField(
              controller: _titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Add a title',
                hintStyle: TextStyle(color: Colors.black54),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
            //Description
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.edit, size: 22, color: Colors.grey),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    maxLines: 5,
                    // maxLength: 10,
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Add a description',
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
            //Create button
            ElevatedButton(
              style: TextButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
                context.read<TaskProviders>().addtask(
                  id: DateTime.now().microsecondsSinceEpoch,
                  title: _titleController.text.trim(),
                  description: _descriptionController.text.trim(),
                  isdone: false,
                );
              },
              child: Text('Create', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
