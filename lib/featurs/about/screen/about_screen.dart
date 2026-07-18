import 'package:flutter/material.dart';
import '../../../common/custom_color.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        title: const Text(
          "LEGAL & SAFETY HUB",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.8, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Branding section
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 100,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.shield,
                      color: AppColors.secondary,
                      size: 80,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "SADIA'S EMPIRE",
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                  ),
                  const Text(
                    "Tactical Firearm & Gear Network v1.0.0",
                    style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Safety alert box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        "CRITICAL LEGAL DISCLAIMER",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "All firearm transactions completed via Sadia's Empire are subject to federal, state, and local laws. Buyers must be of legal age, possess valid state identification, pass a NICS background check, and pick up their purchase at a licensed Federal Firearms License (FFL) dealer. Direct shipping to non-licensed individuals is strictly prohibited.",
                    style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Standard Gun Safety Rules
            const Text(
              "FOUR RULES OF FIREARM SAFETY",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.5),
            ),
            const SizedBox(height: 12),
            _buildSafetyRule("1", "Treat every firearm as if it is loaded.", "Always verify the chamber status yourself. Never assume."),
            _buildSafetyRule("2", "Never point a gun at anything you don't intend to destroy.", "Keep your muzzle pointed in a safe direction at all times."),
            _buildSafetyRule("3", "Keep your finger off the trigger until sights are on target.", "Keep your index finger indexed along the receiver until ready to shoot."),
            _buildSafetyRule("4", "Be sure of your target and what is beyond it.", "Always check your backdrop and target surrounding environment."),

            const SizedBox(height: 24),

            // FFL Dealer System Info
            const Text(
              "HOW ONLINE GUN SALES WORK",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.5),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildFflStep(Icons.add_shopping_cart, "Step 1: Purchase Online", "Select the firearm of your choice and complete the purchase inside the app."),
                  const Divider(color: Color(0xFF334155), height: 24),
                  _buildFflStep(Icons.store, "Step 2: Choose Local FFL Dealer", "Specify which certified local dealer you want the seller to ship the weapon to."),
                  const Divider(color: Color(0xFF334155), height: 24),
                  _buildFflStep(Icons.local_shipping, "Step 3: Track Shipment", "The seller ships the gun directly to the selected FFL dealer. Track it via your Armory tab."),
                  const Divider(color: Color(0xFF334155), height: 24),
                  _buildFflStep(Icons.fact_check_outlined, "Step 4: Background Check & Pickup", "Visit the dealer, present your ID/Permit, pass the background check, and claim your firearm."),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyRule(String number, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
            ),
            child: Text(
              number,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFflStep(IconData icon, String title, String desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.secondary, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(color: AppColors.textMuted, fontSize: 11, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
