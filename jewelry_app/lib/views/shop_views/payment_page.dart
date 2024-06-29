import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:jewelry_app/components/my_login_register_button.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/model/card_model.dart';
import 'package:jewelry_app/view_model/payment_page_view_model.dart';
import 'package:jewelry_app/views/auth_views/auth_page.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late PaymentPageViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<PaymentPageViewModel>(context, listen: false);
  }

  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar,
      body: _buildBody(context),
    );
  }

  get _buildAppbar => AppBar(
        title: Text(MyTexts.instance.siparisiTamamlaText),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            _viewModel.cardNumber = "";
            _viewModel.expiryDate = "";
            _viewModel.cardHolderName = "";
            _viewModel.cvvCode = "";
          },
          icon: const Icon(Icons.arrow_back),
        ),
      );

  _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildCreditCardWidget(context),
          _buildCreditCardForm(context),
        ],
      ),
    );
  }

  _buildCreditCardWidget(BuildContext context) {
    return Consumer<PaymentPageViewModel>(
      builder: (context, value, child) {
        return CreditCardWidget(
          cardBgColor: MyColors.loginRegisterButtonColor,
          enableFloatingCard: value.useFloatingAnimation,
          cardNumber: value.cardNumber,
          expiryDate: value.expiryDate,
          cardHolderName: value.cardHolderName,
          cvvCode: value.cvvCode,
          frontCardBorder: value.useGlassMorphism ? null : Border.all(color: Colors.grey),
          backCardBorder: value.useGlassMorphism ? null : Border.all(color: Colors.grey),
          showBackView: value.isCvvFocused,
          obscureCardNumber: true,
          obscureCardCvv: true,
          isHolderNameVisible: true,
          isSwipeGestureEnabled: true,
          onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
        );
      },
    );
  }

  _buildCreditCardForm(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CreditCardForm(
              formKey: formKey,
              obscureCvv: true,
              obscureNumber: true,
              cardNumber: _viewModel.cardNumber,
              cvvCode: _viewModel.cvvCode,
              isHolderNameVisible: true,
              isCardNumberVisible: true,
              isExpiryDateVisible: true,
              cardHolderName: _viewModel.cardHolderName,
              expiryDate: _viewModel.expiryDate,
              onCreditCardModelChange: _viewModel.onCreditCardModelChange,
            ),
            _buildSwitchButton,
            _buildOdemeyiTamamlaButton(context),
          ],
        ),
      ),
    );
  }

  get _buildSwitchButton => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(
            color: MyColors.myBorderColor,
          )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                MyTexts.instance.saveCardText,
                style: const TextStyle(
                  color: MyColors.blackColor,
                  fontSize: 15,
                ),
              ),
              Consumer<PaymentPageViewModel>(
                builder: (context, value, child) {
                  return CupertinoSwitch(
                    activeColor: MyColors.loginRegisterButtonColor,
                    value: value.switchValue,
                    onChanged: value.onSwitchValueChange,
                  );
                },
              ),
            ],
          ),
        ),
      );

  _buildOdemeyiTamamlaButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: MyLoginRegisterButton(
        onTap: () {
          if (formKey.currentState!.validate()) {
            CardModel cardModel = CardModel(
              cardNumber: _viewModel.cardNumber,
              date: _viewModel.expiryDate,
              userName: _viewModel.cardHolderName,
              cvv: _viewModel.cvvCode,
              isCv: _viewModel.isCvvFocused,
            );
            if (_viewModel.switchValue == true) {
              _viewModel.saveToCreditCardFromRepo(context, cardModel);
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AuthPage(),
              ),
            );
          }
        },
        text: MyTexts.instance.odemeyiTamamlaText,
        color: MyColors.loginRegisterButtonColor,
        textColor: MyColors.whiteColor,
      ),
    );
  }
}
