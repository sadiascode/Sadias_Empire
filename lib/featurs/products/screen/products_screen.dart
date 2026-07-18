import 'package:flutter/material.dart';
import '../../../common/app_state.dart';
import '../../../common/custom_color.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String _selectedCategory = "All";
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = ["All", "Handguns", "Rifles", "Shotguns", "Optics", "Ammo"];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final role = AppState.currentRole;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        title: Text(
          role == UserRole.buyer ? "ARMORY CATALOG" : "MY INVENTORY",
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.8, fontSize: 16),
        ),
        actions: [
          if (role == UserRole.seller)
            IconButton(
              icon: const Icon(Icons.add_circle, color: AppColors.secondary, size: 28),
              onPressed: () => _showAddProductDialog(context),
            )
        ],
      ),
      body: Column(
        children: [
          // Search & Filter header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {});
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.darkCard,
                hintText: "Search weapons, scopes, caliber...",
                hintStyle: const TextStyle(color: AppColors.textMuted),
                prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Categories horizontal scroll
          SizedBox(
            height: 38,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = _selectedCategory == cat;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = cat;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.secondary : AppColors.darkCard,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Colors.transparent : AppColors.primary.withOpacity(0.5),
                      ),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textMuted,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Products List/Grid
          Expanded(
            child: ValueListenableBuilder<List<Firearm>>(
              valueListenable: AppState.firearmsNotifier,
              builder: (context, firearms, child) {
                // Filter the list
                final query = _searchController.text.toLowerCase();
                final filtered = firearms.where((gun) {
                  final matchesCat = _selectedCategory == "All" || gun.category == _selectedCategory;
                  final matchesSearch = gun.name.toLowerCase().contains(query) ||
                      gun.caliber.toLowerCase().contains(query) ||
                      gun.description.toLowerCase().contains(query);
                  return matchesCat && matchesSearch;
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(
                    child: Text(
                      "No weapons match search filters.",
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final gun = filtered[index];
                    return _buildProductGridCard(gun, role == UserRole.buyer);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGridCard(Firearm gun, bool isBuyer) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.5)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                gun.imageUrl,
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 110,
                  color: Colors.grey[800],
                  child: const Icon(Icons.image_not_supported, color: Colors.white54),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    gun.condition,
                    style: const TextStyle(color: Colors.amber, fontSize: 9, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                      const SizedBox(height: 1),
                      Text(
                        "Caliber: ${gun.caliber}",
                        style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${gun.price.toStringAsFixed(2)}",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isBuyer ? AppColors.primary : Colors.grey[800],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          if (isBuyer) {
                            _showProductPurchaseSheet(context, gun);
                          } else {
                            // Seller options (edit/delete simulation)
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Listing options for ${gun.name} (Simulation)"),
                                backgroundColor: AppColors.primary,
                              ),
                            );
                          }
                        },
                        child: Text(
                          isBuyer ? "Buy" : "Edit",
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showProductPurchaseSheet(BuildContext context, Firearm gun) {
    String selectedFFL = "Sadia's Gun Emporium (FFL #5-74-XXX-01)";

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        gun.name,
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white54),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    gun.description,
                    style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "CHOOSE REGISTERED FFL DEALER FOR SHIPMENT",
                    style: TextStyle(color: AppColors.secondary, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.darkBackground,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primary.withOpacity(0.5)),
                    ),
                    child: DropdownButton<String>(
                      value: selectedFFL,
                      dropdownColor: AppColors.darkCard,
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                      isExpanded: true,
                      underline: const SizedBox(),
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      onChanged: (val) {
                        if (val != null) {
                          setSheetState(() {
                            selectedFFL = val;
                          });
                        }
                      },
                      items: const [
                        DropdownMenuItem(
                          value: "Sadia's Gun Emporium (FFL #5-74-XXX-01)",
                          child: Text("Sadia's Gun Emporium (FFL #5-74-XXX-01)"),
                        ),
                        DropdownMenuItem(
                          value: "Elite Armory Station (FFL #1-32-YYY-45)",
                          child: Text("Elite Armory Station (FFL #1-32-YYY-45)"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Total Price", style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                          Text(
                            "\$${gun.price.toStringAsFixed(2)}",
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          // Create order
                          final order = FirearmOrder(
                            orderId: "ORD-${1000 + firearmsNotifierLength()}",
                            firearm: gun,
                            buyerName: "John Doe",
                            buyerEmail: "john.doe@example.com",
                            fflDealer: selectedFFL,
                            date: "Today",
                            status: "FFL Processing",
                          );
                          AppState.addOrder(order);

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Purchase request submitted! Background check pending for ${gun.name}."),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        child: const Text("Order Weapon", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  int firearmsNotifierLength() {
    return AppState.ordersNotifier.value.length;
  }

  void _showAddProductDialog(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final caliberController = TextEditingController();
    final descController = TextEditingController();
    String category = "Handguns";
    String condition = "New";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.darkCard,
          title: const Text("LIST NEW WEAPON", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "Weapon Name",
                    labelStyle: TextStyle(color: AppColors.textMuted),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
                  ),
                ),
                const SizedBox(height: 10),
                // Category dropdown
                const Text("Category", style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                DropdownButton<String>(
                  value: category,
                  dropdownColor: AppColors.darkCard,
                  isExpanded: true,
                  style: const TextStyle(color: Colors.white),
                  underline: Container(height: 1, color: AppColors.primary),
                  onChanged: (val) {
                    if (val != null) {
                      category = val;
                    }
                  },
                  items: const [
                    DropdownMenuItem(value: "Handguns", child: Text("Handguns")),
                    DropdownMenuItem(value: "Rifles", child: Text("Rifles")),
                    DropdownMenuItem(value: "Shotguns", child: Text("Shotguns")),
                    DropdownMenuItem(value: "Optics", child: Text("Optics")),
                    DropdownMenuItem(value: "Ammo", child: Text("Ammo")),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "Price (\$)",
                    labelStyle: TextStyle(color: AppColors.textMuted),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: caliberController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "Caliber (e.g. 9mm, .223)",
                    labelStyle: TextStyle(color: AppColors.textMuted),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Condition", style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                DropdownButton<String>(
                  value: condition,
                  dropdownColor: AppColors.darkCard,
                  isExpanded: true,
                  style: const TextStyle(color: Colors.white),
                  underline: Container(height: 1, color: AppColors.primary),
                  onChanged: (val) {
                    if (val != null) {
                      condition = val;
                    }
                  },
                  items: const [
                    DropdownMenuItem(value: "New", child: Text("New")),
                    DropdownMenuItem(value: "Like New", child: Text("Like New")),
                    DropdownMenuItem(value: "Used", child: Text("Used")),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(color: AppColors.textMuted),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CANCEL", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary),
              onPressed: () {
                if (nameController.text.isEmpty || priceController.text.isEmpty) {
                  return;
                }
                final gun = Firearm(
                  id: "${DateTime.now().millisecondsSinceEpoch}",
                  name: nameController.text,
                  category: category,
                  price: double.tryParse(priceController.text) ?? 0.0,
                  caliber: caliberController.text,
                  condition: condition,
                  description: descController.text,
                  sellerName: "Empire Tactical Armory",
                  imageUrl: "https://images.unsplash.com/photo-1608156639585-b3a032ef9689?auto=format&fit=crop&q=80&w=400",
                );
                AppState.addFirearm(gun);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${gun.name} listed successfully!"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text("SUBMIT", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
