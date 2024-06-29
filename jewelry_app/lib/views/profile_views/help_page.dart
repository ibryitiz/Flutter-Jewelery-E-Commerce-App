import 'package:flutter/material.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/views/gemini_chat_view/gemini_page.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar,
      body: _buildBody(context),
    );
  }

  get _buildAppbar => AppBar(
        iconTheme: const IconThemeData(
          color: MyColors.whiteColor,
        ),
        title: Text(
          MyTexts.instance.helpText,
          style: const TextStyle(
            color: MyColors.whiteColor,
          ),
        ),
        backgroundColor: MyColors.loginRegisterButtonColor,
      );

  _buildBody(BuildContext context) => Column(
        children: [
          _buildFirstContainer(context),
          _buildSecondContainer(context),
          _buildThirdContainer(context),
        ],
      );

  _buildFirstContainer(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height / 2.7,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            border: Border.all(
              color: MyColors.myBorderColor,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text(
              MyTexts.instance.liveHelpText,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _buildGreenContainer(context)
          ],
        ),
      );

  _buildGreenContainer(BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GeminiApiPage(),
              ));
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 4.2,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(
                color: MyColors.greenColor,
              ),
              color: MyColors.greenColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.question_answer_outlined,
                color: MyColors.greenColor,
                size: 75,
              ),
              Text(
                MyTexts.instance.liveHelp,
                style: const TextStyle(
                  color: MyColors.greenColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                MyTexts.instance.helpTimeText,
                style: TextStyle(
                  color: MyColors.bluGreyColor,
                  fontSize: 15,
                ),
              )
            ],
          ),
        ),
      );

  _buildSecondContainer(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height / 10,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: MyColors.myBorderColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.help_outline,
              size: 30,
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  MyTexts.instance.questionsText,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  MyTexts.instance.answerText,
                  style: TextStyle(
                    fontSize: 14,
                    color: MyColors.bluGreyColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  _buildThirdContainer(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height / 13,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          color: MyColors.blueColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info,
              color: MyColors.darkBlueColor,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Wrap(
                children: [
                  Text(
                    MyTexts.instance.iletisimeGececegizText,
                    style: TextStyle(
                      fontSize: 13,
                      color: MyColors.darkBlueColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
