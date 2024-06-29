import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/model/card_model.dart';
import 'package:jewelry_app/view_model/payment_page_view_model.dart';
import 'package:provider/provider.dart';

class MyCreditCardsPage extends StatefulWidget {
  const MyCreditCardsPage({super.key});

  @override
  State<MyCreditCardsPage> createState() => _MyCreditCardsPageState();
}

class _MyCreditCardsPageState extends State<MyCreditCardsPage> {
  late PaymentPageViewModel _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<PaymentPageViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar,
      body: _buildBody(context),
    );
  }

  get _buildAppbar => AppBar(
        iconTheme: const IconThemeData(color: MyColors.whiteColor),
        title: Text(
          MyTexts.instance.savedCardText,
          style: const TextStyle(color: MyColors.whiteColor),
        ),
        backgroundColor: MyColors.loginRegisterButtonColor,
      );

  _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: _viewModel.getCreditCardFromRepo(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(MyTexts.instance.wrongMessage);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.isEmpty) {
          Center(
            child: Text(MyTexts.instance.kartBosText),
          );
        }
        List<CardModel> cards = snapshot.data!;
        return ListView.builder(
          itemCount: cards.length,
          itemBuilder: (context, index) {
            var card = cards[index];
            return Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    icon: Icons.delete_outline,
                    foregroundColor: Colors.red,
                    onPressed: (context) {
                      _viewModel.deleteCreditCards(card);
                    },
                  ),
                ],
              ),
              child: CreditCardWidget(
                cardBgColor: _viewModel.colors[index],
                isHolderNameVisible: true,
                cardNumber: card.cardNumber,
                expiryDate: card.date,
                cardHolderName: card.userName,
                cvvCode: card.cvv,
                showBackView: card.isCv,
                onCreditCardWidgetChange: (p0) {},
              ),
            );
          },
        );
      },
    );
  }
}
