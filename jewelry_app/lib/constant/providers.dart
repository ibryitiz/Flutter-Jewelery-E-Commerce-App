import 'package:jewelry_app/view_model/address_page_view_model.dart';
import 'package:jewelry_app/view_model/auth_view_model/login_or_register_page_view_model.dart';
import 'package:jewelry_app/view_model/auth_view_model/login_page_view_model.dart';
import 'package:jewelry_app/view_model/auth_view_model/register_page_view_model.dart';
import 'package:jewelry_app/view_model/bottom_navigation_view_model.dart';
import 'package:jewelry_app/view_model/details_page_view_model.dart';
import 'package:jewelry_app/view_model/favorite_page_view_model.dart';
import 'package:jewelry_app/view_model/gemini_chat_view_model/gemini_page_view_model.dart';
import 'package:jewelry_app/view_model/home_page_view_model.dart';
import 'package:jewelry_app/view_model/payment_page_view_model.dart';
import 'package:jewelry_app/view_model/profile_page_view_model.dart';
import 'package:jewelry_app/view_model/shop_page_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MyProviders {
  static List<SingleChildWidget> getProviders = [
    ChangeNotifierProvider(
      create: (context) => LoginOrRegisterPageViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => LoginPageViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProfilePageViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => RegisterPageViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => HomePageViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => FavoritePageViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => ShopPageViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => DetailsPageViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => BottomNavigationViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => AddressPageViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => PaymentPageViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => GeminiPageViewModel(),
    ),
  ];
}
