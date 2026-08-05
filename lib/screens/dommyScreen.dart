import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MyAnimation()));
}

class MyAnimation extends StatefulWidget {
  const MyAnimation({super.key});

  @override
  State<MyAnimation> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AnimatedContainer")),
      body: Center(
        child: GestureDetector(
          onTap: () => setState(() {
            selected = !selected;
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
            width: selected ? 12000 : 120,
            height: selected ? 12000 : 120,
            decoration: BoxDecoration(
              color: selected
                  ? const Color.fromARGB(255, 7, 67, 115)
                  : const Color.fromARGB(255, 98, 98, 224),
              borderRadius: BorderRadius.circular(selected ? 40 : 10),
            ),
          ),
        ),
      ),
    );
  }
}
