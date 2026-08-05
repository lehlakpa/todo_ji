import 'package:flutter/material.dart';
import 'package:todo_ji/screens/login_screen.dart';
import 'package:todo_ji/widgets/custom_buttom.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", height: 200, width: 200),
            Text("welcome to dodo_JI "),
            SizedBox(height: 20),
            CustomButton(
              text: "Next",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
