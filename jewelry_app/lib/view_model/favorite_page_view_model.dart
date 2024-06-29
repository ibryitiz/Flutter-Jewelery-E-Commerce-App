import 'package:flutter/material.dart';
import 'package:jewelry_app/model/product_model.dart';
import 'package:jewelry_app/repository/firestore_repository.dart';

class FavoritePageViewModel with ChangeNotifier {
  FavoritePageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getFavoritesByRepo();
    });
  }

  final FirestoreRepository _repository = FirestoreRepository();

  Stream<List<ProductModel>> getFavoritesByRepo() {
    return _repository.getFavoritesByService();
  }

  void deleteFavoritesByRepo(ProductModel productModel) async {
    try {
      await _repository.deleteFavorites(productModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void addBasketsFromRepo(ProductModel productModel) async {
    try {
      await _repository.addBaskets(productModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
