import 'package:flutter/material.dart';
import 'package:my_app/featurs/auth/screen/verify_screen.dart';
import '../../../common/custom_button.dart';
import '../widget/custom_screen.dart';
import '../widget/custom_textfield.dart';


class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScreen(
        svgPath: 'assets/logo.png',
        svgHeight: 240,
        svgWidth: 700,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            const Center(
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Center(
                child: Text(
                  "Enter your email and we will send you a \n                  verification code.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            Text(
              "Email",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              hintText: "Enter your email address",
            ),

            const SizedBox(height: 30),
            CustomButton(
              text: "Send code", onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const VerifyScreen()),
              );},
            ),
          ],
        ),
      ),
    );
  }
}