import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_ji/firebase_options.dart';
import 'package:todo_ji/providers/auth_provider.dart';
import 'package:todo_ji/providers/counter_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_ji/providers/lassan_providers.dart';
import 'package:todo_ji/providers/light_provider.dart';
// import 'package:todo_ji/providers/product_service.dart';
import 'package:todo_ji/providers/task_providers.dart';
// import 'package:todo_ji/screens/counter_screen.dart';
import 'package:todo_ji/screens/dashborad_screen.dart';
// import 'package:todo_ji/screens/dommyScreen.dart';
// import 'package:todo_ji/screens/home_screen.dart';
// import 'package:todo_ji/screens/lassan_screen.dart';
// import 'package:todo_ji/screens/light_screen.dart';
// import 'package:todo_ji/screens/product_screen.dart';
// import 'package:todo_ji/wrapper/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProviders()),
        ChangeNotifierProvider(create: (_) => LightProvider()),
        ChangeNotifierProvider(create: (_) => LassanProviders()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}
