import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jewelry_app/components/my_login_register_button.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/model/address_model.dart';
import 'package:jewelry_app/repository/firestore_repository.dart';

class AddressPageViewModel with ChangeNotifier {
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _cityController;
  late TextEditingController _districtController;
  late TextEditingController _addressController;

  AddressPageViewModel() {
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
    _cityController = TextEditingController();
    _districtController = TextEditingController();
    _addressController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAdressFromRepo();
    });
  }

  final FirestoreRepository _repository = FirestoreRepository();

  void addAddress() async {
    try {
      AddressModel address = AddressModel(
        name: _nameController.text,
        surname: _surnameController.text,
        city: _cityController.text,
        district: _districtController.text,
        address: _addressController.text,
      );
      var addressId = await _repository.addAddress(address);
      address.id = addressId;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<List<AddressModel>> getAdressFromRepo() {
    return _repository.getAddress();
  }

  Future<void> deleteAddress(AddressModel addressModel) async {
    try {
      await _repository.deleteAddress(addressModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: MyColors.whiteColor,
      context: context,
      isScrollControlled: true, // To make bottom sheet scrollable
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(hintText: MyTexts.instance.name),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _surnameController,
                        decoration: InputDecoration(hintText: MyTexts.instance.surname),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _cityController,
                        decoration: InputDecoration(hintText: MyTexts.instance.city),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _districtController,
                        decoration: InputDecoration(hintText: MyTexts.instance.district),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(hintText: MyTexts.instance.adres),
                ),
                const SizedBox(height: 20),
                MyLoginRegisterButton(
                  onTap: () {
                    addAddress();
                    Navigator.pop(context);
                    _nameController.clear();
                    _surnameController.clear();
                    _cityController.clear();
                    _districtController.clear();
                    _addressController.clear();
                  },
                  text: MyTexts.instance.addAddressText,
                  color: MyColors.loginRegisterButtonColor,
                  textColor: MyColors.whiteColor,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  AddressModel? _selectedAddress; // To track radio button selection
  AddressModel? get selectedAddress => _selectedAddress; // Getter
  void setSelectedAddress(AddressModel? address) {
    // Setter
    _selectedAddress = address;
    notifyListeners();
  }

  TextEditingController get nameController => _nameController;
  TextEditingController get surnameController => _surnameController;
  TextEditingController get cityController => _cityController;
  TextEditingController get districtController => _districtController;
  TextEditingController get addressController => _addressController;
}
