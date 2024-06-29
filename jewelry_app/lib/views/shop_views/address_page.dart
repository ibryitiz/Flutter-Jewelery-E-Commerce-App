import 'package:flutter/material.dart';
import 'package:jewelry_app/components/my_login_register_button.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/model/address_model.dart';
import 'package:jewelry_app/view_model/address_page_view_model.dart';
import 'package:jewelry_app/views/shop_views/payment_page.dart';
import 'package:provider/provider.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  late AddressPageViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<AddressPageViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: Column(
        children: [
          Expanded(
            child: _buildBody(context),
          ),
          _buildGoPaymentButton(),
        ],
      ),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: Text(MyTexts.instance.addressText),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            _viewModel.showBottomSheet(context);
          },
        ),
      ],
    );
  }

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

  _buildGoPaymentButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: MyLoginRegisterButton(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PaymentPage(),
              ));
        },
        text: MyTexts.instance.goToPayText,
        color: MyColors.loginRegisterButtonColor,
        textColor: MyColors.whiteColor,
      ),
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
      leading: _buildLeading(address),
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

  _buildLeading(AddressModel address) {
    return Consumer<AddressPageViewModel>(
      builder: (context, viewModel, child) {
        return Radio<AddressModel>(
          value: address,
          groupValue: viewModel.selectedAddress,
          onChanged: (AddressModel? value) {
            viewModel.setSelectedAddress(value);
          },
        );
      },
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
}
