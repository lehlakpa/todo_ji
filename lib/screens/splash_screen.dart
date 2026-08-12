import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_ji/screens/dashborad_screen.dart';
import 'package:todo_ji/screens/login_screen.dart';
import 'package:todo_ji/screens/on_boading_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool firstTime = prefs.getBool('firstTime') ?? true;
    final name = prefs.getString('name');
    print(name);

    if (firstTime) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => OnboardingScreen()),
        );
      });
    } else {
      final currentUser = await FirebaseAuth.instance.currentUser;
      final isLoggedIn = currentUser != null;
      if (isLoggedIn) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DashboardScreen()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/app_logo.png', height: 170)),
    );
  }
}
