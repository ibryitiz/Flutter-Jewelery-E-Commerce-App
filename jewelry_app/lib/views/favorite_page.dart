import 'package:flutter/material.dart';
import 'package:jewelry_app/components/my_favorite_list_tile.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/model/product_model.dart';
import 'package:jewelry_app/view_model/favorite_page_view_model.dart';
import 'package:jewelry_app/views/details_page.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late FavoritePageViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<FavoritePageViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar,
      body: _buildBody(context),
    );
  }

  get _buildAppbar => AppBar(
        elevation: 0,
        backgroundColor: MyColors.transparentColor,
        automaticallyImplyLeading: false,
        title: Text(
          MyTexts.instance.favoritesText,
          style: const TextStyle(
            color: MyColors.blackColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  _buildBody(BuildContext context) {
    return StreamBuilder<List<ProductModel>>(
      stream: _viewModel.getFavoritesByRepo(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(MyTexts.instance.wrongMessage);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data!.isEmpty) {
          return Center(
            child: Text(MyTexts.instance.favoriBosText),
          );
        }
        List<ProductModel> products = snapshot.data!;
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            var product = products[index];
            return MyFavoriteListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(productModel: product),
                  ),
                );
              },
              name: product.name,
              url: product.url,
              price: product.price,
              basketPressed: () {
                _viewModel.addBasketsFromRepo(product);
              },
              deleteButton: () {
                _viewModel.deleteFavoritesByRepo(product);
              },
            );
          },
        );
      },
    );
  }
}
