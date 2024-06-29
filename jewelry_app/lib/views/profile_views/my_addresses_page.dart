import 'package:flutter/material.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/model/address_model.dart';
import 'package:jewelry_app/view_model/address_page_view_model.dart';
import 'package:provider/provider.dart';

class MyAdressesPage extends StatefulWidget {
  const MyAdressesPage({super.key});

  @override
  State<MyAdressesPage> createState() => _MyAdressesPageState();
}

class _MyAdressesPageState extends State<MyAdressesPage> {
  late AddressPageViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<AddressPageViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar,
      body: _buildBody(context),
      floatingActionButton: _buildFabButton(context),
    );
  }

  get _buildAppbar => AppBar(
        iconTheme: const IconThemeData(color: MyColors.whiteColor),
        title: Text(
          MyTexts.instance.myAddressText,
          style: const TextStyle(color: MyColors.whiteColor),
        ),
        backgroundColor: MyColors.loginRegisterButtonColor,
      );

  _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: _viewModel.getAdressFromRepo(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(MyTexts.instance.wrongMessage);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.isEmpty) {
          Center(
            child: Text(MyTexts.instance.adresBosText),
          );
        }
        List<AddressModel> addressList = snapshot.data!;
        return ListView.builder(
          itemCount: addressList.length,
          itemBuilder: (context, index) {
            var address = addressList[index];
            return _buildListAddressContainer(address);
          },
        );
      },
    );
  }

  _buildListAddressContainer(AddressModel address) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: MyColors.myBorderColor,
        ),
      ),
      child: _buildListTile(address),
    );
  }

  _buildListTile(AddressModel address) {
    return ListTile(
      title: _buildTitle(address),
      trailing: _buildTrailing(address),
      subtitle: _buildSubtitle(address),
    );
  }

  _buildTitle(AddressModel address) {
    return Text("${address.name}  ${address.surname}");
  }

  _buildSubtitle(AddressModel address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${address.city}  ${address.district}"),
        Text(address.address),
      ],
    );
  }

  _buildTrailing(AddressModel address) {
    return IconButton(
      icon: const Icon(
        Icons.delete_outline,
        color: MyColors.redColor,
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(MyTexts.instance.deleteToAddress),
          action: SnackBarAction(
            label: MyTexts.instance.yesText,
            onPressed: () {
              _viewModel.deleteAddress(address);
            },
          ),
        ));
      },
    );
  }

  _buildFabButton(BuildContext context) {
    return FloatingActionButton(
      elevation: 2,
      backgroundColor: MyColors.loginRegisterButtonColor,
      onPressed: () {
        _viewModel.showBottomSheet(context);
      },
      child: const Icon(
        Icons.add,
        color: MyColors.whiteColor,
      ),
    );
  }
}
