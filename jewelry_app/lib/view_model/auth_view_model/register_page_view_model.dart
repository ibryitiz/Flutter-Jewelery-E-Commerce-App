import 'package:flutter/material.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/model/user_model.dart';
import 'package:jewelry_app/repository/auth_repository.dart';

class RegisterPageViewModel with ChangeNotifier {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  RegisterPageViewModel() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }
  final AuthRepository _repository = AuthRepository();

  void register(BuildContext context) async {
    try {
      if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty && _confirmPasswordController.text.isNotEmpty) {
        if (_passwordController.text == _confirmPasswordController.text) {
          UserModel userModel = UserModel(email: _emailController.text, url: MyTexts.instance.logoImage);
          var userId = await _repository.signUp(_emailController.text, _passwordController.text, userModel);
          userModel.id = userId;
        }
      }
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPassworController => _confirmPasswordController;
}
