import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app_firebase/model/product_model.dart';
import 'package:grocery_app_firebase/screens/cart_screen.dart';
import 'package:grocery_app_firebase/screens/main_screen_view_model.dart';
import 'package:grocery_app_firebase/screens/search_screen.dart';
import 'package:grocery_app_firebase/widgets/categories.dart';
import 'package:grocery_app_firebase/widgets/product_cards.dart';
import 'package:grocery_app_firebase/widgets/recent_shop_card.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentCategory = 0;
  void changeCategory(int currentCategory) {
    setState(() {
      this.currentCategory = currentCategory;
    });
  }

  Map<Product, int> boughtProductMap = {};

  void addingBuyProductMethod(Product product, int numberOfProduct) {
    boughtProductMap[product] = numberOfProduct;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (_) => MainScreenViewModel(),
        builder: (context, child) => Scaffold(
          body: Center(
            child: Column(
              children: [
                /// Shopping Cart
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen(
                                    boughtProductMap: boughtProductMap,
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(16),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFE8E8E8),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Icon(Icons.shopping_cart),
                    ),
                  ),
                ),

                /// Search Container
                StreamBuilder<List<Product>>(
                  stream:
                      Provider.of<MainScreenViewModel>(context, listen: false)
                          .getProductList(),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.hasError) {
                      return Center(
                        child: Text('There are an error'),
                      );
                    } else {
                      if (!asyncSnapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        List<Product>? productList = asyncSnapshot.data;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchScreen(
                                          productList: productList,
                                        )));
                          },
                          child: Hero(
                            tag: 'search_box',
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 25, bottom: 25, left: 50, right: 50),
                              width: size.width - 100,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFFC4C4C4).withOpacity(0.71),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Row(
                                  children: [
                                    Icon(Icons.search),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      'SEARCH FRESH FOODS',
                                      style: GoogleFonts.quantico(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),

                /// Categories
                Categories(
                  callback: changeCategory,
                ),

                /// Product Carts
                Align(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: (size.height * 3) / 8 + 32,
                      width: size.width,
                      child: Row(
                        children: [
                          StreamBuilder<List<Product>>(
                            stream: Provider.of<MainScreenViewModel>(context,
                                    listen: false)
                                .getProductList(),
                            builder: (context, asyncSnapshot) {
                              if (asyncSnapshot.hasError) {
                                return Center(
                                  child: Text('There are an error'),
                                );
                              } else {
                                if (!asyncSnapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  List<Product>? productList =
                                      asyncSnapshot.data;
                                  return ShowProducts(
                                    productList: productList,
                                    currentCategory: currentCategory,
                                    boughtProductMap: boughtProductMap,
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Spacer(),

                ///Recent Products
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print(boughtProductMap);
                          },
                          child: Text(
                            'Recent Shop',
                            style: GoogleFonts.quantico(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        StreamBuilder<List<Product>>(
                          stream: Provider.of<MainScreenViewModel>(context,
                                  listen: false)
                              .getProductList(),
                          builder: (context, asyncSnapshot) {
                            if (asyncSnapshot.hasError) {
                              return Center(
                                child: Text('There are an error'),
                              );
                            } else {
                              if (!asyncSnapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                List<Product>? productList = asyncSnapshot.data!
                                    .where((product) =>
                                        product.idNum >=
                                        (asyncSnapshot.data!.length - 3))
                                    .toList();

                                return RecentShopCard(
                                  size: size,
                                  productList: productList,
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowProducts extends StatefulWidget {
  final List<Product>? productList;
  int currentCategory;
  Map<Product, int> boughtProductMap;

  ShowProducts(
      {required this.productList,
      required this.currentCategory,
      required this.boughtProductMap});

  @override
  _ShowProductsState createState() => _ShowProductsState();
}

class _ShowProductsState extends State<ShowProducts> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var allProductList = widget.productList;
    var fruits =
        allProductList!.where((product) => product.type == 'Fruit').toList();
    var vegetables =
        allProductList.where((product) => product.type == 'Vegetable').toList();
    var dailies =
        allProductList.where((product) => product.type == 'Daily').toList();
    var currentList = allProductList;

    if (widget.currentCategory == 0) {
      currentList = allProductList;
    } else if (widget.currentCategory == 1) {
      currentList = fruits;
    } else if (widget.currentCategory == 2) {
      currentList = vegetables;
    } else if (widget.currentCategory == 3) {
      currentList = dailies;
    }
    return SizedBox(
      width: size.width,
      height: (size.height * 3) / 8 + 32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: currentList.length,
        itemBuilder: (context, index) {
          return ProductCards(
            size: size,
            product: currentList[index],
            boughtProductMap: widget.boughtProductMap,
          );
        },
      ),
    );
  }
}
