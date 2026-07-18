import 'package:flutter/material.dart';
import '../../../common/custom_button.dart';
import '../widget/custom_screen.dart';
import '../widget/custom_textfield.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScreen(
        svgPath: 'assets/logo.png',
        svgHeight: 240,
        svgWidth: 700,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text("Full Name"),
            const SizedBox(height: 6),
            CustomTextfield(
              hintText: "Enter your full name",
            ),

            const SizedBox(height: 12),

            const Text("Email"),
            const SizedBox(height: 6),
            CustomTextfield(
              hintText: "Enter your email",

            ),

            const SizedBox(height: 12),

            const Text("Password"),
            const SizedBox(height: 6),
            CustomTextfield(
              hintText: "Enter password",
              isPassword: true,

            ),

            const SizedBox(height: 20),
            CustomButton(
              text: "Sign Up",
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );},
            ),
          ],
        ),
      ),
    );
  }
}