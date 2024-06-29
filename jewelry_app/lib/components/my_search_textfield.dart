import 'package:flutter/material.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';

class MySearchTextField extends StatelessWidget {
  final void Function(String) onChanged;

  const MySearchTextField({
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        onChanged: onChanged,
        style: _buildTextStyle(MyColors.loginRegisterButtonColor),
        decoration: InputDecoration(
          filled: true,
          fillColor: MyColors.whiteColor,
          hintText: MyTexts.instance.searchText,
          hintStyle: _buildTextStyle(MyColors.loginRegisterButtonColor),
          suffixIcon: const Icon(
            Icons.search,
            color: MyColors.loginRegisterButtonColor,
            size: 24,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(14.0),
            ),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  _buildTextStyle(Color color) => TextStyle(
        color: color,
        fontWeight: FontWeight.w700,
      );
}
