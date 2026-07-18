import 'package:flutter/material.dart';

enum UserRole { buyer, seller }

class Firearm {
  final String id;
  final String name;
  final String category; // Handguns, Rifles, Shotguns, Optics, Ammo, Gear
  final double price;
  final String description;
  final String imageUrl;
  final String condition; // New, Like New, Used
  final String sellerName;
  final String caliber;

  Firearm({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.condition,
    required this.sellerName,
    required this.caliber,
  });
}

class FirearmOrder {
  final String orderId;
  final Firearm firearm;
  final String buyerName;
  final String buyerEmail;
  final String fflDealer;
  final String date;
  String status; // "FFL Processing", "Background Check Pending", "Ready for Pickup", "Completed"

  FirearmOrder({
    required this.orderId,
    required this.firearm,
    required this.buyerName,
    required this.buyerEmail,
    required this.fflDealer,
    required this.date,
    required this.status,
  });
}

class AppState {
  static UserRole currentRole = UserRole.buyer;

  // Notification trigger or listener list for UI update
  static final ValueNotifier<List<Firearm>> firearmsNotifier = ValueNotifier<List<Firearm>>([
    Firearm(
      id: "1",
      name: "Tactical Defender Elite - 9mm",
      category: "Handguns",
      price: 649.99,
      caliber: "9mm Luger",
      condition: "New",
      sellerName: "Empire Tactical Armory",
      description: "Match-grade barrel, customized slide cuts, fiber optic front sights, and enhanced grip texture. Perfect for concealed carry and home defense.",
      imageUrl: "https://images.unsplash.com/photo-1595590424283-b8f17842773f?auto=format&fit=crop&q=80&w=400",
    ),
    Firearm(
      id: "2",
      name: "Specter Carbine Mk-15",
      category: "Rifles",
      price: 1399.99,
      caliber: "5.56x45mm NATO",
      condition: "New",
      sellerName: "Sadia's Gun Emporium",
      description: "Direct impingement system, 16-inch cold hammer-forged barrel, free-float M-LOK handguard, and adjustable stock. Extremely reliable.",
      imageUrl: "https://images.unsplash.com/photo-1608156639585-b3a032ef9689?auto=format&fit=crop&q=80&w=400",
    ),
    Firearm(
      id: "3",
      name: "Shadow Breaker Shotgun",
      category: "Shotguns",
      price: 899.00,
      caliber: "12 Gauge",
      condition: "Like New",
      sellerName: "Viper Arms",
      description: "Semi-automatic tactical shotgun with 7+1 capacity. Ghost ring sights, Picatinny rail for optics, and heavy-duty synthetic stock.",
      imageUrl: "https://images.unsplash.com/photo-1599819811279-d5ad9cccf838?auto=format&fit=crop&q=80&w=400",
    ),
    Firearm(
      id: "4",
      name: "APEX Marksman Scope 4-16x50",
      category: "Optics",
      price: 349.50,
      caliber: "N/A",
      condition: "New",
      sellerName: "Empire Tactical Armory",
      description: "First focal plane reticle, fully multi-coated glass, lockable turrets, and waterproof construction. High precision target acquisition.",
      imageUrl: "https://images.unsplash.com/photo-1595590424283-b8f17842773f?auto=format&fit=crop&q=80&w=400",
    ),
  ]);

  static final ValueNotifier<List<FirearmOrder>> ordersNotifier = ValueNotifier<List<FirearmOrder>>([
    FirearmOrder(
      orderId: "ORD-9824",
      firearm: Firearm(
        id: "1",
        name: "Tactical Defender Elite - 9mm",
        category: "Handguns",
        price: 649.99,
        caliber: "9mm Luger",
        condition: "New",
        sellerName: "Empire Tactical Armory",
        description: "",
        imageUrl: "",
      ),
      buyerName: "John Doe",
      buyerEmail: "john.doe@example.com",
      fflDealer: "Sadia's Gun Emporium (FFL License #5-74-XXX-01)",
      date: "July 18, 2026",
      status: "Background Check Pending",
    ),
  ]);

  static final List<Map<String, dynamic>> mockMessages = [
    {
      "sender": "seller",
      "text": "Hello John, I see you submitted an order for the Tactical Defender. Have you uploaded your concealed carry permit?",
      "time": "5:10 PM",
    },
    {
      "sender": "buyer",
      "text": "Yes, I uploaded it in my profile verification panel under FFL check. Let me know if you need anything else.",
      "time": "5:12 PM",
    },
    {
      "sender": "seller",
      "text": "Got it. We will forward it to the local sheriff for background check verification tomorrow morning.",
      "time": "5:15 PM",
    },
  ];

  static void addFirearm(Firearm gun) {
    final list = List<Firearm>.from(firearmsNotifier.value);
    list.add(gun);
    firearmsNotifier.value = list;
  }

  static void addOrder(FirearmOrder order) {
    final list = List<FirearmOrder>.from(ordersNotifier.value);
    list.add(order);
    ordersNotifier.value = list;
  }

  static void updateOrderStatus(String orderId, String newStatus) {
    final list = List<FirearmOrder>.from(ordersNotifier.value);
    final index = list.indexWhere((o) => o.orderId == orderId);
    if (index != -1) {
      list[index].status = newStatus;
      ordersNotifier.value = list;
    }
  }
}
