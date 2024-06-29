import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/model/card_model.dart';
import 'package:jewelry_app/repository/firestore_repository.dart';

class PaymentPageViewModel with ChangeNotifier {
  final FirestoreRepository _repository = FirestoreRepository();

  String _cardNumber = "";
  String _expiryDate = '';
  String _cardHolderName = '';
  String _cvvCode = '';
  final bool _useFloatingAnimation = false;
  final bool _useGlassMorphism = false;
  bool _isCvvFocused = false;

  String get cardNumber => _cardNumber;
  String get expiryDate => _expiryDate;
  String get cardHolderName => _cardHolderName;
  String get cvvCode => _cvvCode;
  bool get useFloatingAnimation => _useFloatingAnimation;
  bool get useGlassMorphism => _useGlassMorphism;
  bool get isCvvFocused => _isCvvFocused;

  set cardNumber(String value) {
    _cardNumber = value;
    notifyListeners();
  }

  set expiryDate(String value) {
    _expiryDate = value;
    notifyListeners();
  }

  set cardHolderName(String value) {
    _cardHolderName = value;
    notifyListeners();
  }

  set cvvCode(String value) {
    _cvvCode = value;
    notifyListeners();
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    _cardNumber = creditCardModel.cardNumber;
    _expiryDate = creditCardModel.expiryDate;
    _cardHolderName = creditCardModel.cardHolderName;
    _cvvCode = creditCardModel.cvvCode;
    _isCvvFocused = creditCardModel.isCvvFocused;
    notifyListeners();
  }

  void saveToCreditCardFromRepo(BuildContext context, CardModel cardModel) async {
    try {
      await _repository.saveToCreditCards(cardModel);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(MyTexts.instance.cardSuccessSaveText)),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save card: $e')),
      );
    }
  }

  bool _switchValue = false;
  bool get switchValue => _switchValue;
  void onSwitchValueChange(bool value) {
    _switchValue = value;
    notifyListeners();
  }

  Stream<List<CardModel>> getCreditCardFromRepo() {
    return _repository.getSavedCardFromService();
  }

  void deleteCreditCards(CardModel cardModel) async {
    try {
      await _repository.deleteCreditCardFromService(cardModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  final List<Color> _colors = [
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
  ];

  List<Color> get colors => _colors;
}
