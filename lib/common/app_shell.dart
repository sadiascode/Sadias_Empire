import 'package:flutter/material.dart';
import '../featurs/Chat/screen/chat_screen.dart';
import '../featurs/home/screen/home_screen.dart';
import '../featurs/products/screen/products_screen.dart';
import '../featurs/profile/screen/profile_screen.dart';
import '../featurs/orders/screen/orders_screen.dart';
import 'Navbar/bottom_tab_item.dart';
import 'Navbar/custom_bottom_nav.dart';
import 'app_state.dart';

class AppShell extends StatefulWidget {
  final int initialIndex;

  const AppShell({super.key, this.initialIndex = 0});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _currentIndex;
  late final List<BottomTabItem> _bottomTabs;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;

    final role = AppState.currentRole;

    if (role == UserRole.buyer) {
      _bottomTabs = [
        BottomTabItem(
          label: "Home",
          icon: const Icon(Icons.dashboard_outlined),
          page: const HomeScreen(),
        ),
        BottomTabItem(
          label: "Catalog",
          icon: const Icon(Icons.shopping_bag_outlined),
          page: const ProductsScreen(),
        ),
        BottomTabItem(
          label: "Secure Chat",
          icon: const Icon(Icons.forum_outlined),
          page: const ChatScreen(),
          isCenter: true,
        ),
        BottomTabItem(
          label: "My Armory",
          icon: const Icon(Icons.shield_outlined),
          page: const OrdersScreen(),
        ),
        BottomTabItem(
          label: "Profile",
          icon: const Icon(Icons.account_circle_outlined),
          page: const ProfileScreen(),
        ),
      ];
    } else {
      _bottomTabs = [
        BottomTabItem(
          label: "Dashboard",
          icon: const Icon(Icons.analytics_outlined),
          page: const HomeScreen(),
        ),
        BottomTabItem(
          label: "Inventory",
          icon: const Icon(Icons.inventory_2_outlined),
          page: const ProductsScreen(),
        ),
        BottomTabItem(
          label: "Inbox",
          icon: const Icon(Icons.message_outlined),
          page: const ChatScreen(),
          isCenter: true,
        ),
        BottomTabItem(
          label: "FFL Orders",
          icon: const Icon(Icons.fact_check_outlined),
          page: const OrdersScreen(),
        ),
        BottomTabItem(
          label: "Dealer Profile",
          icon: const Icon(Icons.admin_panel_settings_outlined),
          page: const ProfileScreen(),
        ),
      ];
    }

    _pages = _bottomTabs.map((tab) => tab.page).toList();
  }

  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNav(
        tabs: _bottomTabs,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

class SubPageScaffold extends StatelessWidget {
  final Widget body;
  final int parentTabIndex;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;

  const SubPageScaffold({
    super.key,
    required this.body,
    required this.parentTabIndex,
    this.appBar,
    this.backgroundColor,
  });

  static List<BottomTabItem> get _bottomTabs {
    final role = AppState.currentRole;
    if (role == UserRole.buyer) {
      return [
        BottomTabItem(
          label: "Home",
          icon: const Icon(Icons.dashboard_outlined),
          page: const HomeScreen(),
        ),
        BottomTabItem(
          label: "Catalog",
          icon: const Icon(Icons.shopping_bag_outlined),
          page: const ProductsScreen(),
        ),
        BottomTabItem(
          label: "Secure Chat",
          icon: const Icon(Icons.forum_outlined),
          page: const ChatScreen(),
          isCenter: true,
        ),
        BottomTabItem(
          label: "My Armory",
          icon: const Icon(Icons.shield_outlined),
          page: const OrdersScreen(),
        ),
        BottomTabItem(
          label: "Profile",
          icon: const Icon(Icons.account_circle_outlined),
          page: const ProfileScreen(),
        ),
      ];
    } else {
      return [
        BottomTabItem(
          label: "Dashboard",
          icon: const Icon(Icons.analytics_outlined),
          page: const HomeScreen(),
        ),
        BottomTabItem(
          label: "Inventory",
          icon: const Icon(Icons.inventory_2_outlined),
          page: const ProductsScreen(),
        ),
        BottomTabItem(
          label: "Inbox",
          icon: const Icon(Icons.message_outlined),
          page: const ChatScreen(),
          isCenter: true,
        ),
        BottomTabItem(
          label: "FFL Orders",
          icon: const Icon(Icons.fact_check_outlined),
          page: const OrdersScreen(),
        ),
        BottomTabItem(
          label: "Dealer Profile",
          icon: const Icon(Icons.admin_panel_settings_outlined),
          page: const ProfileScreen(),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: backgroundColor ?? const Color(0xFF0F172A),
      appBar: appBar,
      body: body,
      bottomNavigationBar: CustomBottomNav(
        tabs: _bottomTabs,
        currentIndex: parentTabIndex,
        onTap: (index) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => AppShell(initialIndex: index),
            ),
            (route) => false,
          );
        },
      ),
    );
  }
}