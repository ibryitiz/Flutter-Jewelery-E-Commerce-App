import 'package:jewelry_app/model/user_model.dart';
import 'package:jewelry_app/service/firebase/auth_service.dart';

class AuthRepository {
  final AuthService _service = AuthService();

  Future signIn(String email, String password, UserModel userModel) async {
    await _service.signIn(email, password, userModel);
  }

  Future signUp(String email, String password, UserModel userModel) async {
    await _service.signUp(email, password, userModel);
  }

  Future<void> signOut() async {
    await _service.signOut();
  }

  Future<void> takePicture() async {
    await _service.takePicture();
  }

  Future<void> takePictureByCamera() async {
    await _service.takePictureByCamera();
  }

  // Future<UserModel?> getCurrentUserFromService() async {
  //   return _service.getCurrentUser();
  // }

  Stream<UserModel?> getCurrentUserByService() {
    return _service.getCurrentUserByStream();
  }
}
