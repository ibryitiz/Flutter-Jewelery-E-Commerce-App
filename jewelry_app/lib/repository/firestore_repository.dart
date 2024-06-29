import 'dart:async';

import 'package:jewelry_app/model/address_model.dart';
import 'package:jewelry_app/model/card_model.dart';
import 'package:jewelry_app/model/categories_model.dart';
import 'package:jewelry_app/model/product_model.dart';
import 'package:jewelry_app/service/firebase/firestore_service.dart';

class FirestoreRepository {
  final FirestoreService _service = FirestoreService();

  Stream<List<CategoriesModel>> getCategoriesFromService() {
    return _service.getCategories();
  }

  Stream<List<ProductModel>> getProductByCategoryId(String categoryId) {
    return _service.fetchCategoryDataStream(categoryId);
  }

  Future<void> addFavorites(ProductModel productModel) async {
    await _service.addFavoriteProducts(productModel);
  }

  Future<void> deleteFavorites(ProductModel productModel) async {
    await _service.deleteFavoriteProducts(productModel);
  }

  Stream<List<ProductModel>> getFavoritesByService() {
    return _service.getFavorites();
  }

  Future<void> addBaskets(ProductModel productModel) async {
    await _service.addBasketProducts(productModel);
  }

  Future<void> deleteBaskets(ProductModel productModel) async {
    await _service.deleteBasketProducts(productModel);
  }

  Stream<List<ProductModel>> getBaskets() {
    return _service.getBasket();
  }

  Stream<double?> getTotalPriceFromService() {
    return _service.getBasketTotalPrice();
  }

  Future addAddress(AddressModel addressModel) async {
    await _service.addAddress(addressModel);
  }

  Stream<List<AddressModel>> getAddress() {
    return _service.getAddress();
  }

  Future<void> deleteAddress(AddressModel addressModel) async {
    await _service.deleteAddress(addressModel);
  }

  Future<void> saveToCreditCards(CardModel cardModel) async {
    await _service.saveCardToFirestore(cardModel);
  }

  Stream<List<CardModel>> getSavedCardFromService() {
    return _service.getSavedCard();
  }

  Future<void> deleteCreditCardFromService(CardModel cardModel) async {
    await _service.deleteCreditCards(cardModel);
  }

  Stream<bool> getProductIsSelectedFromService(ProductModel productModel) {
    return _service.getProductIsSelected(productModel);
  }
}
