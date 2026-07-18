import 'package:flutter/material.dart';
import '../featurs/auth/screen/login_screen.dart';
import '../common/app_shell.dart';

class SadiasEmpire extends StatelessWidget {
  const SadiasEmpire({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sadias Empire",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/main': (context) => const AppShell(),
      },
    );
  }
}