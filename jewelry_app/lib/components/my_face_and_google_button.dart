import 'package:flutter/material.dart';

class MyFaceAndGoogleButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color? color;
  final Color? textColor;
  final String assetName;
  const MyFaceAndGoogleButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.color,
    required this.textColor,
    required this.assetName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Gölge rengi
              spreadRadius: 0.5, // Gölgenin yayılma miktarı
              blurRadius: 8, // Gölgenin bulanıklık miktarı
              offset: const Offset(0, 5), // Gölgenin x ve y eksenindeki konumu
            ),
          ],
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: _buildSignInText,
      ),
    );
  }

  Widget get _buildSignInText => Center(
        child: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            CircleAvatar(
              maxRadius: 15,
              backgroundImage: AssetImage(
                assetName,
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: textColor,
              ),
            ),
          ],
        ),
      );
}
