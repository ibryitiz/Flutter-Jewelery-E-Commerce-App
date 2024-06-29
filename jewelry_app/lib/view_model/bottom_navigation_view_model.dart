import 'package:flutter/material.dart';
import 'package:jewelry_app/views/favorite_page.dart';
import 'package:jewelry_app/views/home_page.dart';
import 'package:jewelry_app/views/profile_views/profile_page.dart';
import 'package:jewelry_app/views/shop_views/shop_page.dart';

class BottomNavigationViewModel with ChangeNotifier {
  final List<Widget> _pages = [
    const HomePage(),
    const FavoritePage(),
    const ShopPage(),
    const ProfilePage(),
  ];

  List<Widget> get pages => _pages;

  int _selectedItemPosition = 0;
  int get selectedItemPosition => _selectedItemPosition;
  set selectedItemPosition(int value) {
    _selectedItemPosition = value;
    notifyListeners();
  }
}
