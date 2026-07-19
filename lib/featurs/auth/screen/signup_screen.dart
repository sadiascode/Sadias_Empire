import 'package:flutter/material.dart';
import '../../../common/custom_button.dart';
import '../../../common/custom_color.dart';
import '../../../common/app_state.dart';
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Operational Role Toggle
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

              const Text("Full Name", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              CustomTextfield(
                hintText: "Enter your full name",
                textColor: AppColors.primary,
              ),

              const SizedBox(height: 12),

              const Text("Email", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              CustomTextfield(
                hintText: "Enter your email",
                textColor: AppColors.primary,
              ),

              const SizedBox(height: 12),

              const Text("Password", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              CustomTextfield(
                hintText: "Enter password",
                isPassword: true,
                textColor: AppColors.primary,
              ),

              const SizedBox(height: 20),
              loading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      text: "Sign Up",
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
                              MaterialPageRoute(builder: (_) => const LoginScreen()),
                            );
                          }
                        });
                      },
                    ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}