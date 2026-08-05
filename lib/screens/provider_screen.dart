import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_ji/screens/provider_service.dart';

class ProviderScreen extends StatelessWidget {
  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Practice Provider")),
      body: Center(
        child: Consumer<ProviderService>(
          builder: (context, provider, child) {
            return Text(
              "${provider.count}",
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ProviderService>().increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
