import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/view_model/gemini_chat_view_model/gemini_page_view_model.dart';
import 'package:provider/provider.dart';

class GeminiApiPage extends StatelessWidget {
  const GeminiApiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: MyColors.whiteColor),
        centerTitle: true,
        title: Text(
          MyTexts.instance.geminiTitle,
          style: const TextStyle(color: MyColors.whiteColor),
        ),
        backgroundColor: MyColors.loginRegisterButtonColor,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer<GeminiPageViewModel>(
      builder: (context, value, child) {
        return DashChat(
          inputOptions: InputOptions(trailing: [
            IconButton(
              onPressed: value.sendMediaMessage,
              icon: const Icon(
                Icons.image,
              ),
            )
          ]),
          currentUser: value.currentUser,
          onSend: value.sendMessage,
          messages: value.messages,
        );
      },
    );
  }
}
