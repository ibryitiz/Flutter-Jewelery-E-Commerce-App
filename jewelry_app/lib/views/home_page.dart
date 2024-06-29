import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:jewelry_app/components/my_grid_tile.dart';
import 'package:jewelry_app/components/my_search_textfield.dart';
import 'package:jewelry_app/constant/my_colors.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/model/categories_model.dart';
import 'package:jewelry_app/model/product_model.dart';
import 'package:jewelry_app/view_model/home_page_view_model.dart';
import 'package:jewelry_app/views/details_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageViewModel _viewModel;
  late CarouselController _carouselController;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<HomePageViewModel>(context, listen: false);
    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          _buildAppbar,
          SliverToBoxAdapter(
            child: _buildCarouselSlider(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 5),
          ),
          SliverToBoxAdapter(
            child: _buildIndicator(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: MySearchTextField(
              onChanged: (val) {
                _viewModel.searchName(val);
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: _buildGetCategoriesWidget(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _buildGetProductByCategories();
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  get _buildAppbar => SliverAppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: MyColors.transparentColor,
        pinned: true,
        title: Text(
          MyTexts.instance.title,
          style: const TextStyle(
            color: MyColors.blackColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget _buildCarouselSlider() {
    return CarouselSlider(
      items: _viewModel.items,
      carouselController: _carouselController,
      options: CarouselOptions(
        height: 200.0,
        aspectRatio: 16 / 9,
        viewportFraction: 0.98,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        onPageChanged: (index, reason) {
          _viewModel.currentPages(index);
          debugPrint('Page changed to $index');
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _buildGetCategoriesWidget() {
    return StreamBuilder<List<CategoriesModel>>(
      stream: _viewModel.getCategoriesFromRepo(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(MyTexts.instance.wrongMessage);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        List<CategoriesModel> categories = snapshot.data!;

        return StreamBuilder<String>(
          stream: _viewModel.selectedCategoryStream,
          builder: (context, selectedSnapshot) {
            if (selectedSnapshot.hasError) {
              return Text(MyTexts.instance.wrongMessage);
            }
            if (!selectedSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            String selectedCategoryId = selectedSnapshot.data!;

            return SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  var category = categories[index];
                  bool isSelected = selectedCategoryId == category.id;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        _viewModel.setSelectedCategory(category.id);
                      },
                      child: Chip(
                        side: const BorderSide(color: MyColors.loginRegisterButtonColor),
                        label: Text(category.name),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 30),
                        backgroundColor: isSelected ? MyColors.loginRegisterButtonColor : MyColors.whiteColor,
                        labelStyle: TextStyle(
                          color: isSelected ? MyColors.whiteColor : MyColors.loginRegisterButtonColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildGetProductByCategories() {
    return StreamBuilder<List<ProductModel>>(
      stream: _viewModel.getProducts(),
      builder: (context, productSnapshot) {
        if (productSnapshot.hasError) {
          return Text(MyTexts.instance.wrongMessage);
        }
        if (productSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        List<ProductModel> allProducts = productSnapshot.data ?? [];

        return StreamBuilder<String>(
          stream: _viewModel.nameStream,
          builder: (context, nameSnapshot) {
            List<ProductModel> filteredProducts =
                allProducts.where((product) => product.name.toLowerCase().startsWith(nameSnapshot.data?.toLowerCase() ?? "")).toList();

            if (filteredProducts.isEmpty && _viewModel.name.isNotEmpty) {
              return Center(child: Text(MyTexts.instance.arananUrunBulunamadiText));
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 6.0,
                mainAxisSpacing: 6.0,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                var product = filteredProducts[index];
                return MyGridTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(productModel: product),
                      ),
                    );
                  },
                  url: product.url,
                  name: product.name,
                  price: product.price,
                  isSelected: product.isSelected,
                  onPressed: () {
                    _viewModel.addFavoritesFromRepo(product);
                  },
                  icon: StreamBuilder<bool>(
                    stream: _viewModel.getProductIsSelectedFromRepo(product),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text(MyTexts.instance.wrongMessage);
                      } else {
                        bool value = snapshot.data!;
                        return Icon(
                          value ? Icons.favorite : Icons.favorite_border, // isSelected durumuna göre ikon
                          color: value ? Colors.red : MyColors.blackColor, // isSelected durumuna göre renk
                        );
                      }
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildIndicator() {
    return Consumer<HomePageViewModel>(
      builder: (context, value, child) {
        return DotsIndicator(
          dotsCount: value.items.length,
          position: value.currentPage,
          decorator: const DotsDecorator(
            activeColor: MyColors.loginRegisterButtonColor,
            color: MyColors.loginRegisterTextColor,
          ),
        );
      },
    );
  }
}
