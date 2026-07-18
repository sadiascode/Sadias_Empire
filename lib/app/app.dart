import 'package:flutter/material.dart';
import '../featurs/auth/screen/login_screen.dart';

class SadiasEmpire extends StatelessWidget {
  const SadiasEmpire({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sadias Empire",
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}