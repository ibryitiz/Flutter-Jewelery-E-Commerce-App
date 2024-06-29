import 'package:flutter/material.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';

class MyFavoriteListTile extends StatelessWidget {
  final String name;
  final String url;
  final double price;
  final void Function() basketPressed;
  final void Function() deleteButton;
  final void Function() onTap;
  const MyFavoriteListTile({
    super.key,
    required this.name,
    required this.url,
    required this.price,
    required this.basketPressed,
    required this.deleteButton,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Row(
          children: [
            InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: MyColors.myBorderColor,
                  ),
                ),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  height: 120,
                  width: 120,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "\$${price.toString()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    _buildBasketButton,
                    _buildDeleteButton,
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  get _buildBasketButton => TextButton(
        onPressed: basketPressed,
        child: Text(
          MyTexts.instance.addBasketText,
          style: const TextStyle(
            color: MyColors.loginRegisterButtonColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
  get _buildDeleteButton => TextButton(
        style: const ButtonStyle(
          textStyle: MaterialStatePropertyAll(
            TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          foregroundColor: MaterialStatePropertyAll(
            Colors.red,
          ),
        ),
        onPressed: deleteButton,
        child: Row(
          children: [
            const Icon(Icons.delete_outline),
            Text(
              MyTexts.instance.deleteText,
            ),
          ],
        ),
      );
}
