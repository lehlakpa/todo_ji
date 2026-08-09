
import 'package:flutter/material.dart';

class OverlayDialogs extends StatelessWidget {
  const OverlayDialogs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialogs'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Confirmation Dialog'),
            subtitle: const Text('Ask the user to confirm an action'),
            onTap: () => _showConfirmDialog(context),
          ),

          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Input Dialog'),
            subtitle: const Text('Get text input from the user'),
            onTap: () => _showInputDialog(context),
          ),

          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Multi-Choice Dialog'),
            subtitle: const Text('Select one option'),
            onTap: () => _showMultiChoiceDialog(context),
          ),

          ListTile(
            leading: const Icon(Icons.hourglass_top),
            title: const Text('Loading Dialog'),
            subtitle: const Text('Show progress during an operation'),
            onTap: () => _showLoadingDialog(context),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // 1. CONFIRMATION DIALOG
  // --------------------------------------------------

  Future<void> _showConfirmDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text(
            'Are you sure you want to proceed?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx, false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(ctx, true);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (!context.mounted) return;

    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Confirmed successfully'),
        ),
      );
    }
  }

  // --------------------------------------------------
  // 2. INPUT DIALOG
  // --------------------------------------------------

  Future<void> _showInputDialog(BuildContext context) async {
    final controller = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Enter name'),
          content: TextField(
            controller: controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              hintText: 'Your name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final name = controller.text.trim();

                if (name.isEmpty) {
                  return;
                }

                Navigator.pop(ctx, name);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (!context.mounted) return;

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hello, $result'),
        ),
      );
    }
  }

  // --------------------------------------------------
  // 3. MULTI-CHOICE DIALOG
  // --------------------------------------------------

  Future<void> _showMultiChoiceDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Select option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Option A'),
                onTap: () {
                  Navigator.pop(ctx, 'A');
                },
              ),
              ListTile(
                title: const Text('Option B'),
                onTap: () {
                  Navigator.pop(ctx, 'B');
                },
              ),
              ListTile(
                title: const Text('Option C'),
                onTap: () {
                  Navigator.pop(ctx, 'C');
                },
              ),
            ],
          ),
        );
      },
    );

    if (!context.mounted) return;

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selected Option $result'),
        ),
      );
    }
  }

  // --------------------------------------------------
  // 4. LOADING DIALOG
  // --------------------------------------------------

  Future<void> _showLoadingDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return const AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 24),
              Text('Loading...'),
            ],
          ),
        );
      },
    );

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!context.mounted) return;

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Loading completed'),
      ),
    );
  }
}
```
