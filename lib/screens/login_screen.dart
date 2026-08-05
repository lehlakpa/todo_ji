import 'package:flutter/material.dart';
import 'package:todo_ji/providers/auth_provider.dart';
import 'package:todo_ji/screens/register_screen.dart';
// import 'package:todo_ji/screens/register_screen.dart';
import 'package:todo_ji/widgets/custom_buttom.dart';
import 'package:todo_ji/widgets/custom_text_button.dart';
import 'package:todo_ji/widgets/custom_textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
bool hidePassword = true;
final _formKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Image.asset(
                  "assets/images/onboarding.png",
                  fit: BoxFit.contain,
                  height: 100,
                  width: double.infinity,
                ),
                SizedBox(height: 40),
                Text(
                  "Welcome Back 👋",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                ),
                Text(
                  "Today is a new day. It`s your day. you shape it . Sign in to start managing your tasks",
                  // style: TextStyle(),
                ),
                SizedBox(height: 40),
                Text("Email"),
                //customtextfield for email
                CustomTextFromField(
                  controller: emailController,
                  hintText: "Enter Your Email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }

                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );

                    if (!emailRegex.hasMatch(value)) {
                      return "Enter a valid email address";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 30),
                Text("Password"),
                //customtextfield for password
                CustomTextFromField(
                  controller: passwordController,
                  hintText: "Enter your password",
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    } else if (value.length <= 7) {
                      return "password must be less than 7";
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                      text: "Forget password",
                      onPressed: () {
                        print("forget password");
                      },
                    ),
                    // TextButton(onPressed: () {}, child: Text("Forget password")),
                  ],
                ),
                SizedBox(height: 40),
                CustomButton(
                  text: "Login",
                  isLoading: false,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await AuthProvider().loginUser(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        context: context,
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                      text: "Dont have account ?",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
