import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jewelry_app/model/address_model.dart';
import 'package:jewelry_app/model/card_model.dart';
import 'package:jewelry_app/model/categories_model.dart';
import 'package:jewelry_app/model/product_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<bool> getProductIsSelected(ProductModel productModel) {
    User? currentUser = _auth.currentUser;
    return _firestore
        .collection("users")
        .doc(currentUser!.uid)
        .collection("favorites")
        .where("id", isEqualTo: productModel.id)
        .snapshots()
        .map((event) {
      if (event.docs.isEmpty) {
        return false;
      } else {
        return true;
      }
    });
  }

  Stream<List<CategoriesModel>> getCategories() {
    return _firestore.collection("categories").snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return CategoriesModel.fromMap(doc.data(), key: doc.id);
      }).toList();
    });
  }

  Stream<List<ProductModel>> fetchCategoryDataStream(String categoryId) {
    final productsCollection = FirebaseFirestore.instance.collection('categories').doc(categoryId).collection("products");
    return productsCollection.snapshots().map((event) => event.docs.map((e) => ProductModel.fromMap(e.data(), key: e.id)).toList());
  }

  Future<void> addFavoriteProducts(ProductModel productModel) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection("users").doc(currentUser.uid).collection("favorites").doc(productModel.id).set({
          ...productModel.toMap(key: productModel.id),
        });
      } else {
        throw Exception("User not logged in");
      }
    } catch (e) {
      throw Exception("Failed to add favorite product: ${e.toString()}");
    }
  }

  Future<void> deleteFavoriteProducts(ProductModel productModel) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection("users").doc(currentUser.uid).collection("favorites").doc(productModel.id).delete();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<List<ProductModel>> getFavorites() {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      return _firestore
          .collection("users")
          .doc(currentUser.uid)
          .collection("favorites")
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => ProductModel.fromMap(doc.data(), key: doc.id)).toList());
    } else {
      return const Stream<List<ProductModel>>.empty();
    }
  }

  Future<void> addBasketProducts(ProductModel productModel) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore
            .collection("users")
            .doc(currentUser.uid)
            .collection("baskets")
            .doc(productModel.id)
            .set(productModel.toMap(key: productModel.id));
      }
    } catch (e) {
      throw Exception("Failed to add basket product: ${e.toString()}");
    }
  }

  Future<void> deleteBasketProducts(ProductModel productModel) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection("users").doc(currentUser.uid).collection("baskets").doc(productModel.id).delete();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<List<ProductModel>> getBasket() {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      return _firestore.collection("users").doc(currentUser.uid).collection("baskets").snapshots().map((event) {
        List<ProductModel> products = [];
        for (var doc in event.docs) {
          var product = ProductModel.fromMap(doc.data(), key: doc.id);
          products.add(product);
        }
        return products;
      });
    } else {
      return const Stream<List<ProductModel>>.empty();
    }
  }

  Stream<double?> getBasketTotalPrice() {
    User? currentUser = _auth.currentUser;
    return _firestore.collection("users").doc(currentUser!.uid).collection("baskets").snapshots().map((querySnapshot) {
      double totalPrice = 0.0;

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final price = data['price'];
        if (price is int) {
          totalPrice += price.toDouble();
        } else if (price is double) {
          totalPrice += price;
        }
      }

      return totalPrice;
    });
  }

  Future addAddress(AddressModel addressModel) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        var docId = _firestore.collection("users").doc(currentUser.uid).collection("address").doc().id;
        await _firestore.collection("users").doc(currentUser.uid).collection("address").doc(docId).set(
              addressModel.toMap(key: docId),
            );
      }
    } catch (e) {
      throw Exception("Failed to add address: ${e.toString()}");
    }
  }

  Future<void> deleteAddress(AddressModel addressModel) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection("users").doc(currentUser.uid).collection("address").doc(addressModel.id).delete();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<List<AddressModel>> getAddress() {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      return _firestore.collection("users").doc(currentUser.uid).collection("address").snapshots().map((event) {
        List<AddressModel> addresses = [];
        for (var doc in event.docs) {
          var address = AddressModel.fromMap(doc.data(), key: doc.id);
          addresses.add(address);
        }
        return addresses;
      });
    } else {
      return const Stream<List<AddressModel>>.empty();
    }
  }

  Future<void> saveCardToFirestore(CardModel cardModel) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        var cardsSnapshot = await _firestore.collection("users").doc(currentUser.uid).collection("cards").get();
        var cardCount = cardsSnapshot.docs.length;

        if (cardCount < 6) {
          var docId = _firestore.collection("users").doc(currentUser.uid).collection("cards").doc().id;
          await _firestore.collection("users").doc(currentUser.uid).collection("cards").doc(docId).set(cardModel.toMap(key: docId));
        } else {
          throw Exception("Kart sayısı 6'dan fazla olduğu için yeni kart eklenemiyor.");
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteCreditCards(CardModel cardModel) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection("users").doc(currentUser.uid).collection("cards").doc(cardModel.id).delete();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<List<CardModel>> getSavedCard() {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      return _firestore.collection("users").doc(currentUser.uid).collection("cards").snapshots().map((event) {
        List<CardModel> cards = [];
        for (var doc in event.docs) {
          var card = CardModel.fromMap(doc.data(), key: doc.id);
          cards.add(card);
        }
        return cards;
      });
    } else {
      return const Stream<List<CardModel>>.empty();
    }
  }
}
