import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/model/product_model.dart';
import 'package:jewelry_app/view_model/shop_page_view_model.dart';
import 'package:jewelry_app/views/shop_views/address_page.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  late ShopPageViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<ShopPageViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar,
      body: _buildBody,
    );
  }

  get _buildAppbar => AppBar(
        elevation: 0,
        backgroundColor: MyColors.transparentColor,
        automaticallyImplyLeading: false,
        title: Text(
          MyTexts.instance.basketsText,
          style: const TextStyle(
            color: MyColors.blackColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  get _buildBody => Column(
        children: [
          StreamBuilder<List<ProductModel>>(
            stream: _viewModel.getBasketsFromRepo(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(MyTexts.instance.wrongMessage);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(MyTexts.instance.sepetBosText),
                );
              }
              List<ProductModel> products = snapshot.data!;
              return Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    var product = products[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Slidable(
                        endActionPane: ActionPane(motion: const StretchMotion(), children: [
                          // delete option
                          SlidableAction(
                            onPressed: (context) {
                              _viewModel.deleteBasketsFromRepo(product);
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: ListTile(
                            title: Text(
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              product.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true, // Optional for softer line breaks
                            ),
                            trailing: Text(
                              "\$${product.price.toString()}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: Image.network(
                              product.url,
                              height: 100,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          _buildBuyContainer,
        ],
      );

  get _buildBuyContainer => StreamBuilder(
        stream: _viewModel.getTotalPriceFromRepo(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(MyTexts.instance.wrongMessage);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          var totalPrice = snapshot.data!;
          String formattedPrice = totalPrice.toStringAsFixed(2);
          return Container(
            decoration: const BoxDecoration(
              color: MyColors.loginRegisterButtonColor,
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "\$$formattedPrice",
                  style: const TextStyle(
                    fontSize: 28,
                    color: MyColors.whiteColor,
                  ),
                ),
                MaterialButton(
                  color: MyColors.whiteColor,
                  child: Text(
                    MyTexts.instance.siparisiTamamlaText,
                    style: const TextStyle(
                      color: MyColors.blackColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddressPage(),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      );
}
