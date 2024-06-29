import 'package:flutter/material.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar,
      body: _buildBody,
    );
  }

  get _buildAppbar => AppBar(
        iconTheme: const IconThemeData(color: MyColors.whiteColor),
        title: Text(
          MyTexts.instance.myBasketsText,
          style: const TextStyle(color: MyColors.whiteColor),
        ),
        backgroundColor: MyColors.loginRegisterButtonColor,
      );

  get _buildBody => Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          _myListTile(
            MyTexts.instance.orderTitleText,
            MyTexts.instance.orderSubtitleText,
            MyTexts.instance.orderSitiationTextOne,
            MyColors.greenColor,
            MyColors.greenColor.withOpacity(0.1),
          ),
          _myListTile(
            MyTexts.instance.orderTitleText,
            MyTexts.instance.orderSubtitleText,
            MyTexts.instance.orderSitiationTextTwo,
            MyColors.redColor,
            MyColors.redColor.withOpacity(0.1),
          ),
          _myListTile(
            MyTexts.instance.orderTitleText,
            MyTexts.instance.orderSubtitleText,
            MyTexts.instance.orderSitiationTextThree,
            MyColors.orangeColor,
            MyColors.orangeColor.withOpacity(0.1),
          ),
        ],
      );

  _myListTile(String title, String subtitle, String orderSitiation, Color orderColor, orderBgColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Container(
          height: 7,
          width: 7,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: MyColors.orangeColor,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: orderBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            orderSitiation,
            style: TextStyle(color: orderColor),
          ),
        ),
      ),
    );
  }
}
