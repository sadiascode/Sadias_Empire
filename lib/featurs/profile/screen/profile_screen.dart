import 'package:flutter/material.dart';
import '../../../common/app_state.dart';
import '../../../common/custom_color.dart';

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
        title: const Text(
          "SECURE PROFILE",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.8, fontSize: 16),
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
                  "JD",
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
                          "John Doe",
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
                      "john.doe@example.com",
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
              _buildPermitItem(
                Icons.badge_outlined,
                "Concealed Carry Weapon (CCW)",
                "Permit ID: #CCW-NY-9824\nExpires: 08/2029",
                "VERIFIED",
                Colors.green,
              ),
              const Divider(color: Color(0xFF334155), height: 24),
              _buildPermitItem(
                Icons.shield_outlined,
                "State Firearm Owner ID (FOID)",
                "FOID ID: #FOID-1082-99\nExpires: 05/2031",
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
              _buildProfileOption(Icons.room_preferences_outlined, "Preferred Local FFL Dealer", "Sadia's Gun Emporium"),
              _buildProfileOption(Icons.history, "My Purchase History", "1 Completed Order"),
              _buildProfileOption(Icons.fingerprint, "Biometric Authentication", "FaceID Enabled"),
              _buildProfileOption(Icons.security, "Data Privacy & Encryption", "AES-256 Enabled"),
            ],
          ),
        ),

        const SizedBox(height: 20),
        Center(
          child: TextButton(
            onPressed: () {
              AppState.currentRole = UserRole.buyer;
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
            child: const Text(
              "Log Out Secure Session",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
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
              _buildPermitItem(
                Icons.document_scanner_outlined,
                "Federal Firearms License (FFL)",
                "License: #5-74-032-01-XX-9824\nExpires: 10/2028",
                "ACTIVE",
                Colors.green,
              ),
              const Divider(color: Color(0xFF334155), height: 24),
              _buildPermitItem(
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
              _buildProfileOption(Icons.business, "Storefront & Pickup Location", "55 Empire Blvd, New York"),
              _buildProfileOption(Icons.contact_phone, "Assigned Agent Phone", "+1 (800) 555-FIRE"),
              _buildProfileOption(Icons.policy_outlined, "Shipping & Compliance Rules", "Ground Shipping Only"),
              _buildProfileOption(Icons.inventory, "Automated NICS Report", "Connected to ATF NICS Link"),
            ],
          ),
        ),

        const SizedBox(height: 20),
        Center(
          child: TextButton(
            onPressed: () {
              AppState.currentRole = UserRole.buyer;
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
            child: const Text(
              "Log Out Secure Session",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildPermitItem(IconData icon, String title, String details, String statusText, Color statusColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.secondary, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 4),
              Text(details, style: const TextStyle(color: AppColors.textMuted, fontSize: 11, height: 1.3)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: statusColor),
          ),
          child: Text(
            statusText,
            style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOption(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: AppColors.secondary),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_forward_ios, color: AppColors.textMuted, size: 12),
        ],
      ),
      onTap: () {},
    );
  }
}
