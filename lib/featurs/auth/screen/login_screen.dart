import 'package:flutter/material.dart';
import '../../../common/custom_button.dart';
import '../widget/custom_screen.dart';
import '../widget/custom_textfield.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: CustomScreen(
        svgPath: 'assets/logo.png',
        svgHeight: 240,
        svgWidth: 700,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const Text(
                "Welcome to Tech Zone",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Enter Email", style: TextStyle(color: Colors.black87)),
            const SizedBox(height: 6),
            CustomTextfield(
              hintText: "Enter Your Email",
            ),
            const SizedBox(height: 12),
            const Text("Password", style: TextStyle(color: Colors.black87)),
            const SizedBox(height: 6),
            CustomTextfield(
              hintText: "Enter Your Password",
              isPassword: true,
            ),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          rememberMe = value ?? false;
                        });
                      },
                      checkColor: Colors.white,
                      activeColor: Colors.amber,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      "Remember Me",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),

            const SizedBox(height: 10),

            loading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
              text: "Sign in", onTap: () {  },

            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                ),
                GestureDetector(
                  onTap: () {

                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
]     ),
    ),
    );
  }
}