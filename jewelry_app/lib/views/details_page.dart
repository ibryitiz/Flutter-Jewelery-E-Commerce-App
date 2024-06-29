import 'package:flutter/material.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/model/product_model.dart';
import 'package:jewelry_app/view_model/details_page_view_model.dart';
import 'package:jewelry_app/view_model/home_page_view_model.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final ProductModel productModel;
  const DetailsPage({super.key, required this.productModel});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late DetailsPageViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<DetailsPageViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            _buildImage,
            _buildBackButton,
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.productModel.name,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _viewModel.addFavoritesFromRepo(widget.productModel);
                      },
                      child: _buildFavoriteButton(),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Expanded(
                  flex: 10,
                  child: SingleChildScrollView(
                    child: Text(
                      widget.productModel.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    _buildSizeContainer(
                      "S",
                      MyColors.loginRegisterButtonColor,
                      MyColors.loginRegisterButtonColor,
                      MyColors.whiteColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildSizeContainer(
                      "M",
                      MyColors.whiteColor,
                      MyColors.blackColor,
                      MyColors.blackColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildSizeContainer(
                      "L",
                      MyColors.whiteColor,
                      MyColors.blackColor,
                      MyColors.blackColor,
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: _buildBuyNowRow,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  get _buildImage => Image.network(
        widget.productModel.url,
        fit: BoxFit.cover,
        width: double.infinity,
      );
  get _buildBackButton => Positioned(
        top: 40,
        left: 10,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: MyColors.myShadowColor.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: MyColors.blackColor,
            ),
          ),
        ),
      );

  _buildFavoriteButton() {
    HomePageViewModel homeViewModel = Provider.of(context, listen: false);
    return StreamBuilder(
      stream: homeViewModel.getProductIsSelectedFromRepo(widget.productModel),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text(MyTexts.instance.wrongMessage);
        } else {
          bool value = snapshot.data!;
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: MyColors.myShadowColor.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              value ? Icons.favorite : Icons.favorite_border, // isSelected durumuna göre ikon
              color: value ? Colors.red : MyColors.blackColor, // isSelected durumuna göre renk
            ),
          );
        }
      },
    );
  }

  get _buildBuyNowRow => Row(
        children: [
          Text(
            "\$${widget.productModel.price}",
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              _viewModel.addBasketsFromRepo(widget.productModel);
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              decoration: BoxDecoration(
                color: MyColors.loginRegisterButtonColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                MyTexts.instance.addBasketText,
                style: const TextStyle(
                  color: MyColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      );

  _buildSizeContainer(String size, Color color, Color borderColor, Color? textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: borderColor,
          )),
      child: Text(
        size,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
