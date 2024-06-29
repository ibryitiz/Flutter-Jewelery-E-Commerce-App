import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:jewelry_app/components/my_bottom_navigation.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/view_model/bottom_navigation_view_model.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavigationViewModel>(
        builder: (context, viewModel, child) {
          return viewModel.pages[viewModel.selectedItemPosition];
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar,
    );
  }

  get _buildBottomNavigationBar => Consumer<BottomNavigationViewModel>(
        builder: (context, value, child) {
          return MyBottomNavigation(
            snakeShape: SnakeShape.indicator,
            selectedItemPosition: value.selectedItemPosition,
            onTap: (index) {
              value.selectedItemPosition = index;
            },
            selectedColor: MyColors.loginRegisterButtonColor,
          );
        },
      );
}
