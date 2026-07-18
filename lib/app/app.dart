import 'package:flutter/material.dart';
import '../featurs/auth/screen/login_screen.dart';


class TechZone extends StatelessWidget {
  const TechZone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tech Zone",
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}