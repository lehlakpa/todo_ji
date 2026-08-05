import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_ji/providers/light_provider.dart';

class LightScreen extends StatefulWidget {
  const LightScreen({super.key});

  @override
  State<LightScreen> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<LightScreen> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            setState(() {
              selected = !selected;
            });

            context.read<LightProvider>().toggleLight();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: selected
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Colors.blue),
                  )
                : Container(
                    height: 130,
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 56, 18, 246),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
          ),
          // child: AnimatedContainer(
          //   duration: const Duration(milliseconds: 500),
          //   // curve: Curves.easeIn,
          //   curve: Curves.easeInOut,
          //   width: selected ? 12000 * 2 : 120,
          //   height: selected ? 12000 * 2 : 120,
          //   decoration: BoxDecoration(
          //     color: selected ? Colors.blue : const Color(0xFF506FF2),
          //     // shape: BoxShape.circle,
          //     borderRadius: BorderRadius.circular(100),
          //     // selected ? 40 : 10
          //   ),
          // ),
        ),
      ),
    );
  }
}
