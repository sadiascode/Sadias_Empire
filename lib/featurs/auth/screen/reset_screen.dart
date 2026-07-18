import 'package:flutter/material.dart';
import '../../../common/custom_button.dart';
import '../widget/custom_screen.dart';
import '../widget/custom_textfield.dart';
import 'login_screen.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  bool loading = false;


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
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Set a new password",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Center(
                child: Text(
                  "Create a new password. Ensure it differs \n        from previous ones for security",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 35),
            CustomTextfield(
              hintText: "New Password",
              isPassword: true,
            ),
            const SizedBox(height: 15),
            CustomTextfield(
              hintText: "Retype New Password",
              isPassword: true,
            ),
            const SizedBox(height: 30),
            loading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
              text: "Reset password",
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}