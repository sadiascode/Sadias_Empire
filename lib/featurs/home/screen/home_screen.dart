import 'package:flutter/material.dart';
import 'package:sadias_empire/featurs/home/widget/firearm_card.dart';
import '../../../common/app_state.dart';
import '../../../common/custom_color.dart';
import '../widget/build_category_card.dart';
import '../widget/chart_bar.dart';
import '../widget/state_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = "All";

  final List<Map<String, dynamic>> _allFirearms = [
    {"imageUrl": 'assets/M9A4.png', "category": "Handgun", "title": "M9A4", "caliber": "9×19mm", "price": 1249.00},
    {"imageUrl": 'assets/mcx_lt.jpeg', "category": "Rifle", "title": "MCX LT", "caliber": "5.56×45mm", "price": 1999.00},
    {"imageUrl": 'assets/model10.jpg', "category": "Handgun", "title": "S&W Model 10", "caliber": ".38 Special", "price": 749.00},
    {"imageUrl": 'assets/XR.jpg', "category": "Rifle", "title": "XR-15", "caliber": "5.56", "price": 1499.00},
    {"imageUrl": 'assets/colt1849.webp', "category": "Handgun", "title": "Colt 1849", "caliber": ".31 Caliber", "price": 899.00},
    {"imageUrl": 'assets/beretta.png', "category": "Shotgun", "title": "Beretta A300 Solid Marsh", "caliber": "12 Gauge", "price": 1099.00},
    {"imageUrl": 'assets/beretta_a300.jpeg', "category": "Shotgun", "title": "A300 Ultima", "caliber": "12 Gauge", "price": 1099.00},
    {"imageUrl": 'assets/air_rifle.jpeg', "category": "Air Rifle", "title": "AirForce Texan", "caliber": ".45 Cal", "price": 1299.00},
  ];

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
              errorBuilder: (context, error, stackTrace) =>
              const Icon(
                Icons.radar,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              role == UserRole.buyer ? "SADIA'S EMPIRE" : "DEALER COMMAND",
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
              child: Icon(
                  Icons.notifications_active_outlined, color: Colors.white),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (route) => false);
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
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
                BuildCategoryCard(
                  title: "All",
                  subtitle: 'View All',
                  icon: Icons.list,
                  onTap: () {
                    setState(() { _selectedCategory = "All"; });
                  },
                ),
                BuildCategoryCard(
                  title: "Handguns",
                  subtitle: 'Pistols',
                  icon: Icons.settings,
                  onTap: () {
                    setState(() { _selectedCategory = "Handguns"; });
                  },
                ),
                BuildCategoryCard(
                  title: "Rifles",
                  icon: Icons.api,
                  subtitle: "Assault & Carbine",
                  onTap: () {
                    setState(() { _selectedCategory = "Rifles"; });
                  },
                ),
                BuildCategoryCard(
                  title: "Shotguns",
                  icon: Icons.crop_portrait,
                  subtitle: "Heavy Duty",
                  onTap: () {
                    setState(() { _selectedCategory = "Shotguns"; });
                  },
                ),
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
              children: _allFirearms.where((item) {
                if (_selectedCategory == "All") return true;
                if (_selectedCategory == "Handguns" && item["category"] == "Handgun") return true;
                if (_selectedCategory == "Rifles" && item["category"] == "Rifle") return true;
                if (_selectedCategory == "Shotguns" && item["category"] == "Shotgun") return true;
                return false;
              }).map((item) => FirearmCard(
                imageUrl: item["imageUrl"],
                category: item["category"],
                title: item["title"],
                caliber: item["caliber"],
                price: item["price"],
                onTap: () {},
              )).toList(),
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
                const Icon(Icons.shield_outlined, color: AppColors.secondary,
                    size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Important Information",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "We're committed to making the buying process simple and compliant with federal law."
                            "Every firearm purchase is securely shipped to a licensed FFL dealer, where a background check is completed before pickup.",
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
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF271B11), Color(0xFF0F172A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: AppColors.secondary.withOpacity(0.5), width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Dealer Operations",
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 1.0,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.green),
                        ),
                        child: const Text(
                          "ONLINE",
                          style: TextStyle(color: Colors.green,
                              fontSize: 9,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Empire Sadia Ltd.",
                    style: TextStyle(color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "FFL License: #5-74-Yeo-Bro-XX-9824",
                    style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),

            const Text(
              "COMMERCIAL STATS",
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 0.5),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              padding: EdgeInsets.zero,
              childAspectRatio: 1.7,
              children: [
                StatCard(title: "Total Revenue",
                    value: "\$48,920.00",
                    icon: Icons.monetization_on,
                    iconColor: Colors.green),
                StatCard(title: "Pending FFL Check",
                    value: "1 Orders",
                    icon: Icons.pending_actions,
                    iconColor: AppColors.secondary),
                StatCard(title: "Items Listed",
                    value: "4 Weapons",
                    icon: Icons.inventory_2_outlined,
                    iconColor: AppColors.accent),
                StatCard(title: "Average Rating",
                    value: "4.9 (182)",
                    icon: Icons.star,
                    iconColor: Colors.amber),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "MONTHLY REVENUE TREND",
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 0.5),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 170,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text("\$50k", style: TextStyle(
                            color: AppColors.textMuted, fontSize: 11)),
                        Text("\$25k", style: TextStyle(
                            color: AppColors.textMuted, fontSize: 11)),
                        Text("0", style: TextStyle(
                            color: AppColors.textMuted, fontSize: 11)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 170,
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ChartBar(height: 50, month: "Jan"),
                          ChartBar(height: 90, month: "Feb"),
                          ChartBar(height: 70, month: "Mar"),
                          ChartBar(height: 120, month: "Apr"),
                          ChartBar(height: 100, month: "May"),
                          ChartBar(height: 140, month: "Jun"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 65),
          ],
        ),
      ),
    );
  }
}