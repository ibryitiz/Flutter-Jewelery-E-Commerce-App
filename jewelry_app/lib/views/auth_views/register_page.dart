import 'package:flutter/material.dart';
import 'package:jewelry_app/components/my_face_and_google_button.dart';
import 'package:jewelry_app/components/my_login_register_button.dart';
import 'package:jewelry_app/components/my_textfield.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/view_model/auth_view_model/login_or_register_page_view_model.dart';
import 'package:jewelry_app/view_model/auth_view_model/register_page_view_model.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              MyColors.loginRegisterBackgroundColor1,
              MyColors.loginRegisterBackgroundColor2,
              MyColors.loginRegisterBackgroundColor3,
            ],
          ),
        ),
        child: _buildSigleChildScroolView(context),
      ),
    );
  }

  Widget _buildSigleChildScroolView(BuildContext context) => SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildBigColumn(context),
          ),
        ),
      );

  _buildBigColumn(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _mySizedBox(25, 0),
          _buildTitle,
          _mySizedBox(20, 0),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: _buildSmallColumn(context)),
        ],
      ),
    );
  }

  Widget get _buildTitle => Text(
        MyTexts.instance.signUpText,
        style: const TextStyle(
          color: MyColors.loginRegisterTextColor,
          fontSize: 28,
          fontWeight: FontWeight.w900,
        ),
      );

  _buildSmallColumn(BuildContext context) {
    RegisterPageViewModel viewModel = Provider.of(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          MyTexts.instance.emailText,
          style: const TextStyle(
            color: MyColors.loginRegisterTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        _mySizedBox(10, 0),
        MyTextField(
          controller: viewModel.emailController,
          obscureText: false,
        ),
        _mySizedBox(10, 0),
        Text(
          MyTexts.instance.passwordText,
          style: const TextStyle(
            color: MyColors.loginRegisterTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        _mySizedBox(10, 0),
        MyTextField(
          controller: viewModel.passwordController,
          obscureText: true,
          icon: const Icon(
            Icons.remove_red_eye,
            color: MyColors.loginRegisterButtonColor,
            size: 28,
          ),
        ),
        _mySizedBox(10, 0),
        Text(
          MyTexts.instance.confirmPasswordText,
          style: const TextStyle(
            color: MyColors.loginRegisterTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        _mySizedBox(10, 0),
        MyTextField(
          controller: viewModel.confirmPassworController,
          obscureText: true,
          icon: const Icon(
            Icons.remove_red_eye,
            color: MyColors.loginRegisterButtonColor,
            size: 28,
          ),
        ),
        _mySizedBox(20, 0),
        MyLoginRegisterButton(
          onTap: () {
            viewModel.register(context);
          },
          text: MyTexts.instance.signUpText,
          color: MyColors.loginRegisterButtonColor,
          textColor: MyColors.loginRegisterBackgroundColor3,
        ),
        _mySizedBox(20, 0),
        Center(
          child: Text(
            MyTexts.instance.orSignUpWithText,
            style: const TextStyle(
              color: MyColors.loginRegisterTextColor,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        _mySizedBox(15, 0),
        MyFaceAndGoogleButton(
          onTap: () {},
          text: MyTexts.instance.signUpWithFaceText,
          color: MyColors.textfieldFillColor,
          textColor: MyColors.loginRegisterTextColor,
          assetName: MyTexts.instance.withFaceImageText,
        ),
        _mySizedBox(15, 0),
        MyFaceAndGoogleButton(
          onTap: () {},
          text: MyTexts.instance.signUpWithGoogleText,
          color: MyColors.textfieldFillColor,
          textColor: MyColors.loginRegisterTextColor,
          assetName: MyTexts.instance.withGoogleImageText,
        ),
        _mySizedBox(15, 0),
        Center(
          child: Text(
            MyTexts.instance.alreadyHaveAccountText,
            style: const TextStyle(
              color: MyColors.loginRegisterTextColor,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        _mySizedBox(25, 0),
        MyLoginRegisterButton(
          onTap: () {
            Provider.of<LoginOrRegisterPageViewModel>(context, listen: false)
                .togglePages(Provider.of<LoginOrRegisterPageViewModel>(context, listen: false).isLoginPage);
          },
          text: MyTexts.instance.logInText,
          color: MyColors.getStartedButtonColor,
          textColor: MyColors.loginRegisterTextColor,
        ),
      ],
    );
  }

  Widget _mySizedBox(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
