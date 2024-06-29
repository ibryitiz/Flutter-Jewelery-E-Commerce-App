import 'package:flutter/material.dart';
import 'package:jewelry_app/components/my_login_register_button.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/views/auth_views/auth_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              MyColors.loginRegisterBackgroundColorOne,
              MyColors.loginRegisterBackgroundColorTwo,
              MyColors.loginRegisterBackgroundColorThree,
            ],
          ),
        ),
        child: _buildSafeArea(context),
      );

  Widget _buildSafeArea(BuildContext context) => SafeArea(
        child: Column(
          children: [
            _buildLogo,
            const SizedBox(
              height: 127,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  _buildGetStartedText,
                  const SizedBox(
                    height: 35,
                  ),
                  _buildGetStartedButton(context),
                ],
              ),
            ),
          ],
        ),
      );

  Widget get _buildLogo => Image.asset(
        MyTexts.instance.logoImage,
      );

  Widget get _buildGetStartedText => Text(
        MyTexts.instance.getStartedText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: MyColors.loginRegisterTextColor,
          fontSize: 22,
        ),
      );

  Widget _buildGetStartedButton(BuildContext context) => MyLoginRegisterButton(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthPage(),
          ),
        ),
        text: MyTexts.instance.getStartedButtonText,
        color: MyColors.getStartedButtonColor,
        textColor: MyColors.loginRegisterTextColor,
      );
}
