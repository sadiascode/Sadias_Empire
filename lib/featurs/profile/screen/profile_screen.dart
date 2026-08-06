import 'package:flutter/material.dart';
import 'package:sadias_empire/common/custom_button.dart';
import '../../../common/app_state.dart';
import '../../../common/custom_color.dart';
import '../widget/build_permit.dart';
import '../widget/build_profile.dart';
import '../widget/log_out.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final role = AppState.currentRole;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
          child: const Text(
            "PROFILE",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.8, fontSize: 16, color: AppColors.textLight),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: role == UserRole.buyer ? _buildBuyerProfile() : _buildSellerProfile(),
      ),
    );
  }

  Widget _buildBuyerProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User info card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary.withOpacity(0.5)),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primary,
                child: Text(
                  "SRR",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Sadia Rahman Roha",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.green),
                          ),
                          child: const Text(
                            "PASSED CHECK",
                            style: TextStyle(color: Colors.green, fontSize: 9, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Sadia.don@example.com",
                      style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // License & Permit Verification
        const Text(
          "FIREARMS LICENSING & PERMITS",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5),
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
              BuildPermit(
                Icons.badge_outlined,
                "Concealed Carry Weapon (CCW)",
                "Permit ID: #Yeo-Bro\nExpires: 08/2029",
                "VERIFIED",
                Colors.green,
              ),
              const Divider(color: Color(0xFF334155), height: 24),
              BuildPermit(
                Icons.shield_outlined,
                "State Firearm Owner ID (FOID)",
                "FOID ID: #Yeo-Bro-Hey\nExpires: 05/2031",
                "VERIFIED",
                Colors.green,
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Profile Menu Options
        const Text(
          "ACCOUNT MANAGEMENT",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              BuildProfile(Icons.room_preferences_outlined, "Preferred Local FFL Dealer", "Sadia's Gun Emporium"),
              BuildProfile(Icons.history, "My Purchase History", "1 Completed Order"),
              BuildProfile(Icons.fingerprint, "Biometric Authentication", "FaceID Enabled"),
              BuildProfile(Icons.security, "Data Privacy & Encryption", "AES-256 Enabled"),
            ],
          ),
        ),

        const SizedBox(height: 35),
        Center(
          child: Center(
              child: CustomButton(
                  text: "Logout", onTap: (){ LogOut(context);})
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildSellerProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Seller business card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.secondary.withOpacity(0.5)),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.secondary,
                child: Icon(Icons.storefront, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Empire Tactical Armory",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.verified, color: AppColors.secondary, size: 18),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "FFL Class: Type 01 Dealer",
                      style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),


        // Dealer Credentials
        const Text(
          "FEDERAL LICENSE DETAILS (FFL)",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5),
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
              BuildPermit(
                Icons.document_scanner_outlined,
                "Federal Firearms License (FFL)",
                "License: #5-74-032-01-XX-9824\nExpires: 10/2028",
                "ACTIVE",
                Colors.green,
              ),
              const Divider(color: Color(0xFF334155), height: 24),
              BuildPermit(
                Icons.assignment_ind_outlined,
                "SOT Special Occupational Tax",
                "Class: Class 3 SOT (NFA items)\nExpires: 07/2027",
                "ACTIVE",
                Colors.green,
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Profile Menu Options
        const Text(
          "DEALER CONTROL MANAGEMENT",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              BuildProfile(Icons.business, "Storefront & Pickup Location", "55 Empire Blvd, New York"),
              BuildProfile(Icons.contact_phone, "Assigned Agent Phone", "+1 (800) 555-FIRE"),
              BuildProfile(Icons.policy_outlined, "Shipping & Compliance Rules", "Ground Shipping Only"),
              BuildProfile(Icons.inventory, "Automated NICS Report", "Connected to ATF NICS Link"),
            ],
          ),
        ),

        const SizedBox(height: 35),
        Center(
          child: CustomButton(
              text: "Logout", onTap: (){ LogOut(context);})
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}
