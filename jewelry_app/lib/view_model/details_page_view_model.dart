import 'package:flutter/cupertino.dart';
import 'package:jewelry_app/model/product_model.dart';
import 'package:jewelry_app/repository/firestore_repository.dart';

class DetailsPageViewModel with ChangeNotifier {
  final FirestoreRepository _repository = FirestoreRepository();

  void addBasketsFromRepo(ProductModel productModel) async {
    try {
      await _repository.addBaskets(productModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void addFavoritesFromRepo(ProductModel productModel) async {
    try {
      await _repository.addFavorites(productModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
