import 'package:flutter/cupertino.dart';
import 'package:jewelry_app/model/product_model.dart';
import 'package:jewelry_app/repository/firestore_repository.dart';

class ShopPageViewModel with ChangeNotifier {
  final FirestoreRepository _repository = FirestoreRepository();
  ShopPageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getBasketsFromRepo();
    });
  }

  Stream<List<ProductModel>> getBasketsFromRepo() {
    return _repository.getBaskets();
  }

  void deleteBasketsFromRepo(ProductModel productModel) async {
    try {
      await _repository.deleteBaskets(productModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<double?> getTotalPriceFromRepo() {
    return _repository.getTotalPriceFromService();
  }
}
