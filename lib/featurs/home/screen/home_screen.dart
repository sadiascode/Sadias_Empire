import 'package:flutter/material.dart';
import 'package:sadias_empire/featurs/home/widget/firearm_card.dart';
import '../../../common/app_state.dart';
import '../../../common/custom_color.dart';
import '../widget/build_category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final role = AppState.currentRole;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 40,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.radar,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              role == UserRole.buyer ? "EMPIRE DEPOT" : "DEALER COMMAND",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Badge(
              label: Text("1"),
              child: Icon(Icons.notifications_active_outlined, color: Colors.white),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
        ],
      ),
      body: role == UserRole.buyer ? _buildBuyerHome() : _buildSellerHome(),
    );
  }

  Widget _buildBuyerHome() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Banner
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.secondary),
                  ),
                  child: const Text(
                    "Sadia's Empire Arms",
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Licensed Firearms & Tactical Equipment",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Browse our catalog with confidence. Secure transactions through licensed firearm dealers.",
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // Categories Horizontal
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "POPULAR CATEGORIES",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                BuildCategoryCard (  title:"Handguns", subtitle: 'Pistols', icon: Icons.settings,),
                BuildCategoryCard (title: "Rifles",icon:  Icons.api,subtitle:  "Assault & Carbine"),
                BuildCategoryCard (title: "Shotguns",icon:  Icons.crop_portrait,subtitle:  "Heavy Duty"),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Featured Products
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "HOT DEALS & FEATURED",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FirearmCard(
                imageUrl: 'assets/M9A4.png', category: "Handgun",
                title: "M9A4", caliber: "9×19mm",
                price: 1249.00,onTap: (){}, ),

              FirearmCard(
                imageUrl: 'assets/M9A4.png', category: "Handgun",
                title: "M9A4", caliber: "9×19mm",
                price: 1249.00,onTap: (){}, ),

              FirearmCard(
                imageUrl: 'assets/M9A4.png', category: "Handgun",
                title: "M9A4", caliber: "9×19mm",
                price: 1249.00,onTap: (){}, ),

              FirearmCard(
                imageUrl: 'assets/M9A4.png', category: "Handgun",
                title: "M9A4", caliber: "9×19mm",
                price: 1249.00,onTap: (){}, ),

              FirearmCard(
                imageUrl: 'assets/M9A4.png', category: "Handgun",
                title: "M9A4", caliber: "9×19mm",
                price: 1249.00,onTap: (){}, ),
            ],
          ),
         ),

          const SizedBox(height: 20),

          // FFL Dealer Guidelines Card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.darkCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.shield_outlined, color: AppColors.secondary, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Federal Firearm License (FFL) Rule",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Firearms cannot be shipped directly to your house. We ship strictly to a certified FFL dealer near you. You will undergo background check verification at the time of pickup.",
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildSellerHome() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Analytics Welcome card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF271B11), Color(0xFF0F172A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.secondary.withOpacity(0.5), width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "FFL Dealer Active Portal",
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 1.0,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.green),
                        ),
                        child: const Text(
                          "ONLINE",
                          style: TextStyle(color: Colors.green, fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Empire Armory Ltd.",
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "FFL License: #5-74-032-01-XX-9824",
                    style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Dashboard Metrics Grid
            const Text(
              "COMMERCIAL STATS",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildStatCard("Total Revenue", "\$48,920.00", Icons.monetization_on, Colors.green),
                _buildStatCard("Pending FFL Check", "1 Orders", Icons.pending_actions, AppColors.secondary),
                _buildStatCard("Items Listed", "4 Weapons", Icons.inventory_2_outlined, AppColors.accent),
                _buildStatCard("Average Rating", "4.9 (182)", Icons.star, Colors.amber),
              ],
            ),
            const SizedBox(height: 24),

            // Visual Sales Chart Mockup
            const Text(
              "MONTHLY REVENUE TREND",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("\$50k", style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                      Text("\$25k", style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                      Text("0", style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Mock Chart Bar Line
                  Container(
                    height: 80,
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildChartBar(30, "Mar"),
                        _buildChartBar(45, "Apr"),
                        _buildChartBar(20, "May"),
                        _buildChartBar(75, "Jun"),
                        _buildChartBar(90, "Jul"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Quick Operations Buttons
            const Text(
              "RAPID ACTIONS",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.add_a_photo_outlined),
                    label: const Text("New Listing", style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      // Navigate or trigger product dialog
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkCard,
                      foregroundColor: AppColors.secondary,
                      side: const BorderSide(color: AppColors.secondary),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.verified_user_outlined),
                    label: const Text("Verify Buyer FFL", style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      // Trigger order dialog
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }


  Widget _buildFirearmCard(Firearm gun) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            child: Image.network(
              gun.imageUrl,
              height: 100,
              width: 160,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 100,
                color: Colors.grey[800],
                child: const Icon(Icons.image_not_supported, color: Colors.white54),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gun.category.toUpperCase(),
                  style: const TextStyle(color: AppColors.secondary, fontSize: 9, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  gun.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  gun.caliber,
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${gun.price.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_forward_ios, size: 10, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String val, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: AppColors.textMuted, fontSize: 11, fontWeight: FontWeight.bold)),
              Icon(icon, color: color, size: 16),
            ],
          ),
          Text(val, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildChartBar(double heightPercentage, String month) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 24,
          height: heightPercentage,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.secondary, Color(0xFF7C2D12)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Text(month, style: const TextStyle(color: AppColors.textMuted, fontSize: 10)),
      ],
    );
  }
}
