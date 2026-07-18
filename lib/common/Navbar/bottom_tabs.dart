import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../featurs/Chat/screen/chat_screen.dart';
import '../../featurs/about/screen/about_screen.dart';
import '../../featurs/home/screen/home_screen.dart';
import '../../featurs/products/screen/products_screen.dart';
import '../../featurs/profile/screen/profile_screen.dart';
import 'bottom_tab_item.dart';

final List<BottomTabItem> bottomTabs = [
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
    label: "About Us",
    icon: Icon(Icons.info),
    page: AboutScreen(),
  ),
  BottomTabItem(
    label: "Chat",
    icon: Icon(Icons.chat),
    page: ChatScreen(),
    isCenter: true,
  ),
  BottomTabItem(
    label: "Profile",
    icon: Icon(Icons.person),
    page: ProfileScreen(),
  ),
];