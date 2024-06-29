import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/model/categories_model.dart';
import 'package:jewelry_app/model/product_model.dart';
import 'package:jewelry_app/repository/firestore_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomePageViewModel with ChangeNotifier {
  HomePageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCategoriesFromRepo();
      getProducts();
    });
  }

  int _currentPage = 0;
  int get currentPage => _currentPage;
  void currentPages(int value) {
    _currentPage = value;
    notifyListeners();
  }

  final List<Widget> _items = [
    for (int i = 0; i < 3; i++)
      Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            MyTexts.instance.carosuelImage,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
      ),
  ];
  List<Widget> get items => _items;

  final FirestoreRepository _repository = FirestoreRepository();

  // Seçili kategori için BehaviorSubject
  final _selectedCategorySubject = BehaviorSubject<String>.seeded(MyTexts.instance.defaultCategoryId);

  // Seçili kategoriyi ayarlamak için fonksiyon
  void setSelectedCategory(String categoryId) {
    _selectedCategorySubject.add(categoryId);
  }

  // Seçili kategoriyi dinlemek için stream
  Stream<String> get selectedCategoryStream => _selectedCategorySubject.stream;

  // Seçili kategoriye göre ürünleri dinleyen stream
  Stream<List<ProductModel>> getProducts() {
    return _selectedCategorySubject.switchMap((categoryId) {
      return _repository.getProductByCategoryId(categoryId);
    });
  }

  @override
  void dispose() {
    _selectedCategorySubject.close();
    _nameController.close();
    super.dispose();
  }

  Stream<List<CategoriesModel>> getCategoriesFromRepo() {
    return _repository.getCategoriesFromService();
  }

  final _nameController = BehaviorSubject<String>();
  Stream<String> get nameStream => _nameController.stream;

  String _name = "";
  String get name => _name;
  void searchName(String val) {
    _name = val;
    _nameController.add(val); // Update the stream
    notifyListeners();
  }

  void addFavoritesFromRepo(ProductModel productModel) async {
    try {
      await _repository.addFavorites(productModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<bool> getProductIsSelectedFromRepo(ProductModel productModel) {
    return _repository.getProductIsSelectedFromService(productModel);
  }
}
