import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jewelry_app/model/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future signIn(String email, String password, UserModel userModel) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future signUp(String email, String password, UserModel userModel) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return _firestore.collection("users").doc(userCredential.user!.uid).set(userModel.toMap(key: userCredential.user!.uid));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> takePicture() async {
    try {
      final ImagePicker picker = ImagePicker();
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        XFile? file = await picker.pickImage(source: ImageSource.gallery);
        if (file != null) {
          var profileRef = _storage.ref("users/profile_image/${currentUser.uid}");
          var task = profileRef.putFile(File(file.path), SettableMetadata(contentType: 'image/png'));
          await task.whenComplete(() async {
            var url = await profileRef.getDownloadURL();
            await _firestore.collection("users").doc(currentUser.uid).set({
              "url": url.toString(),
            }, SetOptions(merge: true));
          });
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> takePictureByCamera() async {
    try {
      final ImagePicker picker = ImagePicker();

      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        XFile? file = await picker.pickImage(source: ImageSource.camera);
        if (file != null) {
          var profileRef = _storage.ref("users/profile_image/${currentUser.uid}");
          var task = profileRef.putFile(File(file.path), SettableMetadata(contentType: 'image/png'));
          await task.whenComplete(() async {
            var url = await profileRef.getDownloadURL();
            await _firestore.collection("users").doc(currentUser.uid).set({
              "url": url.toString(),
            }, SetOptions(merge: true));
          });
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // UserModel? _currentUser;

  // Future<UserModel?> getCurrentUser() async {
  //   if (_currentUser != null) return _currentUser;
  //   User? user = _auth.currentUser;
  //   if (user != null) {
  //     DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
  //     if (doc.exists) {
  //       _currentUser = UserModel.fromMap(doc.data() as Map<String, dynamic>, key: doc.id);
  //       return _currentUser;
  //     }
  //   }
  //   return null;
  // }

  Stream<UserModel?> getCurrentUserByStream() {
    return _firestore.collection('users').doc(_auth.currentUser!.uid).snapshots().map((doc) {
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>, key: doc.id);
      }
      return null;
    });
  }
}
