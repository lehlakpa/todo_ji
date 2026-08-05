import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_ji/providers/counter_provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CounterProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // if we are in function () we have to apply listen false example
              // provider.of<counterProvider>(context,listen:false).count.tostring()
              // context.watch<CounterProvider>().scount.toString(),
              provider.count.toString(),
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // context.read<CounterProvider>().scount.toString(),
                      provider.Increment();
                    },
                    child: Container(
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.lightBlue,
                      ),
                      child: Center(
                        child: Text(
                          "Increment",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      provider.decrement();
                    },
                    child: Container(
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.lightBlue,
                      ),
                      child: Center(
                        child: Text(
                          "Decrement",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      provider.reset();
                    },
                    child: Container(
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.lightBlue,
                      ),
                      child: Center(
                        child: Text(
                          "Reset",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
