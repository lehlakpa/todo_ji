import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:todo_ji/models/lassan_models.dart';
import 'package:todo_ji/providers/lassan_providers.dart';

class LassanScreen extends StatelessWidget {
  // final LassanModels hello;
  const LassanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LassanProviders>();
    final louda = provider.Lassan;

    return Scaffold(
      appBar: AppBar(title: const Text("Lassan List")),
      body: ListView.builder(
        itemCount: louda.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(louda[index].name),
              subtitle: Text(louda[index].swearWord),

              // Right side icons
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Edit Button
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      final nameController = TextEditingController(
                        text: louda[index].name,
                      );

                      final swearController = TextEditingController(
                        text: louda[index].swearWord,
                      );

                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text("Edit"),

                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    labelText: "Name",
                                  ),
                                ),

                                TextField(
                                  controller: swearController,
                                  decoration: const InputDecoration(
                                    labelText: "Swear Word",
                                  ),
                                ),
                              ],
                            ),

                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),

                              ElevatedButton(
                                onPressed: () {
                                  context.read<LassanProviders>().editlassan(
                                    id: louda[index].id,
                                    name: nameController.text,
                                    swearWord: swearController.text,
                                  );

                                  Navigator.pop(context);
                                },
                                child: const Text("Save"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),

                  // Delete Button
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context.read<LassanProviders>().deleteLassan(
                        louda[index].id,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
