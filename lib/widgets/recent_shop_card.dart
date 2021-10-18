import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app_firebase/model/product_model.dart';

class RecentShopCard extends StatefulWidget {
  final Size size;
  List<Product>? productList;
  RecentShopCard({required this.size, required this.productList});

  @override
  _RecentShopCardState createState() => _RecentShopCardState();
}

class _RecentShopCardState extends State<RecentShopCard> {
  var currentProduct;
  int currentProductIndex = 0;
  bool isVisible = true;

  @override
  void initState() {
    currentProduct = widget.productList![0];
    print(currentProductIndex);
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (currentProductIndex == 0) {
        setState(() {
          currentProductIndex = 1;
        });
        currentProduct = widget.productList![1];
        print(currentProductIndex);
      } else if (currentProductIndex == 1) {
        setState(() {
          currentProductIndex = 2;
        });
        currentProduct = widget.productList![2];
        print(currentProductIndex);
      } else if (currentProductIndex == 2) {
        setState(() {
          currentProductIndex = 0;
        });
        currentProduct = widget.productList![0];
        print(currentProductIndex);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width - 48,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFE8E8E8),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: AnimatedSwitcher(
          duration: Duration(seconds: 1),
          child: Row(
            key: ValueKey<int>(currentProductIndex),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 12),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(currentProduct.colorNum).withOpacity(0.55),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(currentProduct.photoUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentProduct.name,
                    style: GoogleFonts.quantico(
                      fontSize: 16,
                      color: Color(currentProduct.colorNum),
                    ),
                  ),
                  Text(
                    currentProduct.type,
                    style: GoogleFonts.quantico(fontSize: 12),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text:
                              '${(currentProduct.price - currentProduct.price.remainder(1)).round()}',
                          style: GoogleFonts.quantico(
                              fontSize: 16, color: Colors.green)),
                      TextSpan(
                          text:
                              '.${(currentProduct.price.remainder(1) == 0 ? 00 : currentProduct.price.remainder(1) * 100).round()} \$',
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
  }
}
