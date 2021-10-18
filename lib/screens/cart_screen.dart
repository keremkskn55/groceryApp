import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app_firebase/model/product_model.dart';
import 'package:grocery_app_firebase/screens/finishing_shopping_screen.dart';
import 'package:grocery_app_firebase/screens/orders_screen.dart';

class CartScreen extends StatefulWidget {
  Map<Product, int> boughtProductMap;
  CartScreen({required this.boughtProductMap});
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> boughtProductList = [];
  late double totalPrice = 0;

  void boughtProductListCreate() {
    boughtProductList.clear();
    for (var element in widget.boughtProductMap.keys) {
      boughtProductList.add(element);
    }
  }

  void totalPriceCalculator() {
    totalPrice = 0;
    for (var element in widget.boughtProductMap.keys) {
      totalPrice += element.price * (widget.boughtProductMap[element] as int);
    }
  }

  @override
  void initState() {
    boughtProductListCreate();
    totalPriceCalculator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            /// Top Components
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.all(16),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFE8E8E8),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Text(
                  'CART',
                  style:
                      GoogleFonts.quantico(fontSize: 24, color: Colors.black),
                ),
                InkWell(
                  onTap: () {
                    print('former ordered');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrdersScreen()));
                  },
                  child: Container(
                    margin: EdgeInsets.all(16),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFE8E8E8),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Icon(
                      Icons.shopping_basket,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),

            /// List Of Bought Product
            Expanded(
              child: ListView.builder(
                itemCount: boughtProductList.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    actionPane: SlidableScrollActionPane(),
                    actionExtentRatio: 0.2,
                    secondaryActions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: IconSlideAction(
                            caption: 'Remove',
                            color: Colors.redAccent,
                            icon: Icons.restore_from_trash,
                            onTap: () {
                              setState(() {
                                widget.boughtProductMap
                                    .remove(boughtProductList[index]);
                                boughtProductListCreate();
                                totalPriceCalculator();
                              });
                            }),
                      ),
                    ],
                    child: Container(
                      margin: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                      width: size.width - 48,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFE8E8E8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 12),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(boughtProductList[index].colorNum)
                                    .withOpacity(0.55),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      boughtProductList[index].photoUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  boughtProductList[index].name,
                                  style: GoogleFonts.quantico(
                                    fontSize: 16,
                                    color: Color(
                                        boughtProductList[index].colorNum),
                                  ),
                                ),
                                Text(
                                  boughtProductList[index].type,
                                  style: GoogleFonts.quantico(fontSize: 12),
                                ),
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                int tempCurrentNumberOfProduct =
                                    widget.boughtProductMap[
                                        boughtProductList[index]] as int;
                                if (tempCurrentNumberOfProduct != 1) {
                                  setState(() {
                                    tempCurrentNumberOfProduct--;
                                    widget.boughtProductMap[
                                            boughtProductList[index]] =
                                        tempCurrentNumberOfProduct;
                                    boughtProductListCreate();
                                    totalPriceCalculator();
                                  });
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 16),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  color:
                                      Color(boughtProductList[index].colorNum)
                                          .withOpacity(0.16),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color:
                                      Color(boughtProductList[index].colorNum),
                                  size: 16,
                                ),
                              ),
                            ),
                            Text(
                              '${widget.boughtProductMap[boughtProductList[index]]}',
                              style: GoogleFonts.quantico(
                                  fontSize: 16, color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {
                                int tempCurrentNumberOfProduct =
                                    widget.boughtProductMap[
                                        boughtProductList[index]] as int;
                                setState(() {
                                  tempCurrentNumberOfProduct++;
                                  widget.boughtProductMap[
                                          boughtProductList[index]] =
                                      tempCurrentNumberOfProduct;
                                  boughtProductListCreate();
                                  totalPriceCalculator();
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 16, right: 16),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  color:
                                      Color(boughtProductList[index].colorNum),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text:
                                            '${(boughtProductList[index].price - boughtProductList[index].price.remainder(1)).round()}',
                                        style: GoogleFonts.quantico(
                                            fontSize: 16, color: Colors.green)),
                                    TextSpan(
                                        text:
                                            '.${(boughtProductList[index].price.remainder(1) == 0 ? 00 : boughtProductList[index].price.remainder(1) * 100).round()} \$',
                                        style: GoogleFonts.quantico(
                                            fontSize: 12, color: Colors.green)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Buy Of Product
            Container(
              padding: EdgeInsets.only(left: 36, right: 24),
              width: size.width,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFFC4C4C4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'TOTAL PRICE',
                        style: GoogleFonts.quantico(
                          fontSize: 20,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text:
                                    '${(totalPrice - totalPrice.remainder(1)).round()}',
                                style: GoogleFonts.quantico(
                                    fontSize: 20, color: Colors.green)),
                            TextSpan(
                              text:
                                  '.${(totalPrice.remainder(1) == 0 ? 00 : totalPrice.remainder(1) * 100).round()} \$',
                              style: GoogleFonts.quantico(
                                  fontSize: 16, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FinishingShoppingScreen(
                                  boughtProductMap: widget.boughtProductMap)));
                    },
                    child: Container(
                      height: 50,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFF32D32F),
                            Color(0xFF03FFB3),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'BUY ALL',
                          style: GoogleFonts.quantico(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
