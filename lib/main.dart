import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_ji/firebase_options.dart';
import 'package:todo_ji/providers/auth_provider.dart';
import 'package:todo_ji/providers/counter_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_ji/providers/lassan_providers.dart';
import 'package:todo_ji/providers/light_provider.dart';
import 'package:todo_ji/providers/product_service.dart';
import 'package:todo_ji/providers/task_providers.dart';
import 'package:todo_ji/screens/dashborad_screen.dart';
import 'package:todo_ji/service/cloudinary_service.dart';
import 'package:todo_ji/upload_cloudinary/add_product_screen.dart';
import 'package:todo_ji/upload_cloudinary/products_provider.dart';
// import 'package:todo_ji/screens/home_screen.dart';
// import 'package:todo_ji/screens/on_boading_screen.dart';
// import 'package:todo_ji/screens/upload_image.dart';

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
        ChangeNotifierProvider(create: (_) => ProductProvider()),
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
      home: AddProductScreen(),
    );
  }
}
