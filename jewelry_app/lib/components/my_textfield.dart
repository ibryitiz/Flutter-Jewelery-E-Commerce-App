import 'package:flutter/material.dart';
import 'package:jewelry_app/constant/my_colors.dart';

class MyTextField extends StatelessWidget {
  final Icon? icon;
  final TextEditingController controller;
  final bool obscureText;
  const MyTextField({
    super.key,
    required this.controller,
    required this.obscureText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Gölge rengi
            spreadRadius: 0.5, // Gölgenin yayılma miktarı
            blurRadius: 8, // Gölgenin bulanıklık miktarı
            offset: const Offset(0, 5), // Gölgenin x ve y eksenindeki konumu
          ),
        ],
      ),
      child: _buildTextField(context),
    );
  }

  Widget _buildTextField(BuildContext context) => TextField(
        style: const TextStyle(color: MyColors.whiteColor, fontSize: 18),
        obscureText: obscureText,
        controller: controller,
        decoration: _buildDecoration(context),
      );

  _buildDecoration(BuildContext context) {
    return InputDecoration(
      suffixIcon: icon,
      filled: true,
      fillColor: MyColors.textfieldFillColor,
      contentPadding: const EdgeInsets.all(16),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(14.0),
        ),
        borderSide: BorderSide.none,
      ),
    );
  }
}
