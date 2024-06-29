import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:jewelry_app/constant/my_colors.dart';

class MyBottomNavigation extends StatelessWidget {
  final int selectedItemPosition;
  final void Function(int) onTap;
  final SnakeShape snakeShape;
  final Color selectedColor;

  const MyBottomNavigation({
    super.key,
    required this.snakeShape,
    required this.selectedItemPosition,
    required this.onTap,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.color(
      elevation: 3,
      behaviour: SnakeBarBehaviour.floating,
      snakeShape: snakeShape,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      padding: const EdgeInsets.all(12),
      snakeViewColor: MyColors.loginRegisterButtonColor,
      selectedItemColor: snakeShape == SnakeShape.indicator ? selectedColor : null,
      unselectedItemColor: MyColors.bluGreyColor,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      currentIndex: selectedItemPosition,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 25,
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              size: 25,
            ),
            label: 'Favorite'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_outlined,
              size: 25,
            ),
            label: 'Shopping'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
              size: 25,
            ),
            label: 'Person'),
      ],
      selectedLabelStyle: const TextStyle(fontSize: 14),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
    );
  }
}
