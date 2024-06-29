import 'package:flutter/material.dart';
import 'package:jewelry_app/components/my_profile_page_container.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/model/user_model.dart';
import 'package:jewelry_app/view_model/profile_page_view_model.dart';
import 'package:jewelry_app/views/profile_views/help_page.dart';
import 'package:jewelry_app/views/profile_views/my_addresses_page.dart';
import 'package:jewelry_app/views/profile_views/my_credit_cards.dart';
import 'package:jewelry_app/views/profile_views/my_orders_page.dart';
import 'package:jewelry_app/views/profile_views/settings_page.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfilePageViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<ProfilePageViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<UserModel?>(
        stream: _viewModel.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Error handling
          } else if (snapshot.hasData && snapshot.data != null) {
            return _buildBody(context, snapshot.data!);
          } else {
            return Center(child: Text(MyTexts.instance.userNotFoundText)); // Handle null user
          }
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, UserModel userModel) {
    return Stack(
      children: [
        Column(
          children: [
            _buildHelloContainer(userModel),
            Expanded(
              child: _buildProfileListTileColumn,
            ),
          ],
        ),
        _buildProfilePhoto(userModel),
      ],
    );
  }

  _buildHelloContainer(UserModel userModel) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      decoration: const BoxDecoration(
        color: MyColors.loginRegisterButtonColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            MyTexts.instance.helloText,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: MyColors.whiteColor,
            ),
          ),
          Text(
            userModel.email,
            style: const TextStyle(
              fontSize: 24,
              color: MyColors.loginRegisterTextColor,
            ),
          ),
        ],
      ),
    );
  }

  get _buildProfileListTileColumn => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 30,
          ),
          MyContainer(
            text: MyTexts.instance.locationText,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyAdressesPage(),
                ),
              );
            },
            iconData: Icons.location_on_outlined,
          ),
          MyContainer(
            text: MyTexts.instance.myBasketsText,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyOrdersPage(),
                ),
              );
            },
            iconData: Icons.shopping_bag_outlined,
          ),
          MyContainer(
            text: MyTexts.instance.myCardsText,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyCreditCardsPage(),
                ),
              );
            },
            iconData: Icons.credit_card,
          ),
          MyContainer(
            text: MyTexts.instance.helpText,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HelpPage(),
                ),
              );
            },
            iconData: Icons.headset_mic_outlined,
          ),
          MyContainer(
            text: MyTexts.instance.settingsText,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
            iconData: Icons.settings_outlined,
          ),
          MyContainer(
            text: MyTexts.instance.logOutText,
            onPressed: () {
              _viewModel.logOut(context);
            },
            iconData: Icons.logout_rounded,
          ),
        ],
      );

  _buildProfilePhoto(UserModel userModel) {
    return Positioned(
      left: MediaQuery.of(context).size.width / 4,
      top: MediaQuery.of(context).size.height / 6,
      // Fill the entire Stack area
      child: GestureDetector(
        onTap: () {
          _viewModel.showBottomSheet(context);
        },
        child: Container(
          width: 210,
          height: 210,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: userModel.url.contains("assets/")
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      MyTexts.instance.profileImageText,
                    ),
                  )
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(userModel.url),
                  ),
            border: Border.all(
              color: MyColors.whiteColor,
              width: 6,
            ),
          ),
        ),
      ),
    );
  }
}
