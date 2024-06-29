import 'package:flutter/material.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/model/user_model.dart';
import 'package:jewelry_app/repository/auth_repository.dart';

class ProfilePageViewModel with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  void logOut(BuildContext context) async {
    try {
      await _authRepository.signOut();
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

  Stream<UserModel?> getCurrentUser() {
    return _authRepository.getCurrentUserByService();
  }

  // Future<UserModel?> getCurrentUserFromRepo() async {
  //   UserModel? userModel = await _authRepository.getCurrentUserFromService();
  //   return userModel;
  // }

  void takePicture(BuildContext context) async {
    try {
      await _authRepository.takePicture();
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

  void takePictureByCamera(BuildContext context) async {
    try {
      await _authRepository.takePictureByCamera();
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

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: MyColors.whiteColor,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.height * 0.2,
                height: 3,
                color: MyColors.loginRegisterButtonColor,
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 50),
                onTap: () => takePicture(context),
                title: Text(MyTexts.instance.fotografYukleText),
                trailing: const Icon(Icons.photo),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 50),
                onTap: () => takePictureByCamera(context),
                title: Text(MyTexts.instance.kameradanCekText),
                trailing: const Icon(Icons.camera),
              ),
            ],
          ),
        );
      },
    );
  }
}
