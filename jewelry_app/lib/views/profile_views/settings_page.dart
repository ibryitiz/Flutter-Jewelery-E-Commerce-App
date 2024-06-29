import 'package:flutter/material.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
          MyTexts.instance.settingsText,
          style: const TextStyle(color: MyColors.whiteColor),
        ),
        backgroundColor: MyColors.loginRegisterButtonColor,
      );

  get _buildBody => Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(
              MyTexts.instance.kisiselBilgilerimiGuncelleText,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(
              MyTexts.instance.epostaAdresimiGuncelleText,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(
              MyTexts.instance.iletisimTercihlerimiGuncelleText,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(
              MyTexts.instance.hesabimiSilText,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      );
}
