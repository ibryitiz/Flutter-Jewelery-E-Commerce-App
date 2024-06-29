import 'package:flutter/material.dart';
import 'package:jewelry_app/constant/my_colors.dart';

class MyGridTile extends StatelessWidget {
  final void Function() onTap;
  final String url;
  final String name;
  final double price;
  final bool isSelected; // Favori durumu için eklenen alan
  final void Function() onPressed;
  final Widget icon;

  const MyGridTile({
    super.key,
    required this.onTap,
    required this.url,
    required this.name,
    required this.price,
    required this.isSelected, // Favori durumu için eklenen alan
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: _buildDecoration,
          child: Column(
            children: [
              _buildProductImage,
              const SizedBox(height: 10),
              Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: MyColors.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPriceText,
                      _buildFavoriteButton, // Güncellenmiş favori butonu
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  get _buildDecoration => BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: MyColors.myShadowColor.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
      );

  Widget get _buildProductImage => Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget get _buildPriceText => Text(
        "\$${price.toString()}",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: MyColors.blackColor,
        ),
      );

  Widget get _buildFavoriteButton => IconButton(
        onPressed: onPressed,
        icon: icon,
      );
}
