import 'package:flutter/material.dart';
import '../featurs/Chat/screen/chat_screen.dart';
import '../featurs/about/screen/about_screen.dart';
import '../featurs/home/screen/home_screen.dart';
import '../featurs/products/screen/products_screen.dart';
import '../featurs/profile/screen/profile_screen.dart';
import 'Navbar/bottom_tab_item.dart';
import 'Navbar/custom_bottom_nav.dart';


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


    _bottomTabs = [
      BottomTabItem(
        label: "Home",
        icon: Icon(Icons.home),
        page: const HomeScreen(),
      ),
      BottomTabItem(
        label: "Products",
        icon: Icon(Icons.shopping_bag),
        page: ProductsScreen(),
      ),
      BottomTabItem(
        label: "Chat",
        icon: Icon(Icons.chat),
        page: ChatScreen(),
        isCenter: true,
      ),
      BottomTabItem(
        label: "About Us",
        icon: Icon(Icons.info),
        page: AboutScreen(),
      ),
      BottomTabItem(
        label: "Profile",
        icon: Icon(Icons.person),
        page: ProfileScreen(),
      ),
    ];

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


  static List<BottomTabItem> get _bottomTabs => [
    BottomTabItem(
      label: "Home",
      icon: Icon(Icons.home),
      page: HomeScreen(),
    ),
    BottomTabItem(
      label: "Products",
      icon: Icon(Icons.shopping_bag),
      page: ProductsScreen(),
    ),
    BottomTabItem(
      label: "Chat",
      icon: Icon(Icons.info),
      page: ChatScreen(),
      isCenter: true,
    ),
    BottomTabItem(
      label: "About Us",
      icon: Icon(Icons.chat),
      page: AboutScreen(),
    ),
    BottomTabItem(
      label: "Profile",
      icon: Icon(Icons.person),
      page: const SizedBox(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: backgroundColor ?? const Color(0xFFFFFAF7),
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