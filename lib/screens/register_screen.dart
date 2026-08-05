import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_ji/providers/auth_provider.dart';
import 'package:todo_ji/screens/login_screen.dart';
import 'package:todo_ji/widgets/custom_buttom.dart';
import 'package:todo_ji/widgets/custom_text_button.dart';
import 'package:todo_ji/widgets/custom_textformfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

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
                  "Sign up to be get started",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                ),
                SizedBox(height: 40),
                Text("Full Name"),
                CustomTextFromField(
                  controller: nameController,
                  hintText: "Enter your name",
                ),
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
                Text("Password"),
                //customtextfield for password
                CustomTextFromField(
                  controller: passwordController,
                  hintText: "Enter your password",
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    } else if (value.length < 7) {
                      return "Password must be at least 7 characters";
                    }
                    return null;
                  },
                ),
                //customtextfield for confirm password
                Text("Confirm Password"),
                CustomTextFromField(
                  controller: confirmPasswordController,
                  hintText: "Confirm your password",
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    } else if (value != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 40),

                CustomButton(
                  text: "Register",
                  isLoading: auth.isLoading,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await auth.registerUser(
                        fullname: nameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        context: context,
                      );
                    }
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                      text: "Already have an account !",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => LoginScreen()),
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
