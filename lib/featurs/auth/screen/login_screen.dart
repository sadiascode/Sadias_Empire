import 'package:flutter/material.dart';
import '../../../common/custom_button.dart';
import '../../../common/custom_color.dart';
import '../../../common/app_state.dart';
import '../../../common/app_shell.dart';
import '../widget/custom_screen.dart';
import '../widget/custom_textfield.dart';
import 'forget_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  bool loading = false;
  UserRole _selectedRole = UserRole.buyer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: CustomScreen(
        svgPath: 'assets/logo.png',
        svgHeight: 180,
        svgWidth: 320,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Sadia's Empire Arms",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Operational Mode / Role Toggle
              const Text(
                "Select Access Portal",
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 48,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedRole = UserRole.buyer;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            color: _selectedRole == UserRole.buyer
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.my_location,
                                size: 16,
                                color: _selectedRole == UserRole.buyer
                                    ? Colors.white
                                    : AppColors.grey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "Buyer Mode",
                                style: TextStyle(
                                  color: _selectedRole == UserRole.buyer
                                      ? Colors.white
                                      : AppColors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedRole = UserRole.seller;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            color: _selectedRole == UserRole.seller
                                ? AppColors.secondary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shield,
                                size: 16,
                                color: _selectedRole == UserRole.seller
                                    ? Colors.white
                                    : AppColors.grey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "Seller Mode",
                                style: TextStyle(
                                  color: _selectedRole == UserRole.seller
                                      ? Colors.white
                                      : AppColors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                "Enter Email",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              CustomTextfield(
                hintText: "Enter Your Email",
                textColor: AppColors.primary,
              ),
              const SizedBox(height: 12),

              const Text(
                "Password",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              CustomTextfield(
                hintText: "Enter Your Password",
                isPassword: true,
                textColor: AppColors.primary,
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: rememberMe,
                          onChanged: (bool? value) {
                            setState(() {
                              rememberMe = value ?? false;
                            });
                          },
                          checkColor: Colors.white,
                          activeColor: AppColors.primary,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Remember Me",
                        style: TextStyle(fontSize: 14, color: AppColors.grey),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ForgetScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              loading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      text: "Sign in",
                      onTap: () {
                        setState(() {
                          loading = true;
                        });
                        Future.delayed(const Duration(milliseconds: 800), () {
                          if (mounted) {
                            setState(() {
                              loading = false;
                            });
                            AppState.currentRole = _selectedRole;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AppShell(),
                              ),
                            );
                          }
                        });
                      },
                    ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: AppColors.grey, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignupScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}