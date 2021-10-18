import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app_firebase/model/product_model.dart';

class SellingScreen extends StatefulWidget {
  Map<Product, int> boughtProductMap;
  Product product;
  SellingScreen({required this.product, required this.boughtProductMap});

  @override
  _SellingScreenState createState() => _SellingScreenState();
}

class _SellingScreenState extends State<SellingScreen> {
  int countProduct = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: Text('Selling Screen'),
        // ),
        body: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              color: Colors.white,
            ),
            Positioned(
              top: -size.height / 2,
              child: Container(
                width: size.height,
                height: size.height,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.height / 4)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(widget.product.colorNum),
                      Colors.white,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: size.width / 8,
              top: size.height / 5,
              child: Container(
                width: (size.width * 3) / 4,
                height: (size.width * 3) / 4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(widget.product.photoUrl),
                )),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(16),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              left: size.width / 8,
              top: (size.height / 5) + ((3 * size.width) / 4) + 12,
              child: Text(
                widget.product.name.toUpperCase(),
                style: GoogleFonts.quantico(
                  fontSize: 24,
                  color: Color(widget.product.colorNum),
                ),
              ),
            ),
            Positioned(
              left: size.width / 8,
              top: (size.height / 5) + ((3 * size.width) / 4) + 48,
              child: Text(
                widget.product.type.toUpperCase(),
                style: GoogleFonts.quantico(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.56),
                ),
              ),
            ),
            Positioned(
              right: size.width / 8,
              top: (size.height / 5) + ((3 * size.width) / 4) + 30,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (countProduct != 1) {
                        print('printed minus symbol');
                        setState(() {
                          countProduct--;
                        });
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 16),
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        color: Color(widget.product.colorNum).withOpacity(0.16),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Color(widget.product.colorNum),
                      ),
                    ),
                  ),
                  Text(
                    '$countProduct',
                    style:
                        GoogleFonts.quantico(fontSize: 20, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        countProduct++;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        color: Color(widget.product.colorNum),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
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
                          'PRICE',
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
                                      '${(widget.product.price - widget.product.price.remainder(1)).round()}',
                                  style: GoogleFonts.quantico(
                                      fontSize: 20, color: Colors.green)),
                              TextSpan(
                                text:
                                    '.${(widget.product.price.remainder(1) == 0 ? 00 : widget.product.price.remainder(1) * 100).round()} \$',
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
                        setState(() {
                          widget.boughtProductMap[widget.product] =
                              countProduct;
                          Navigator.pop(context);
                        });
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
                            'BUY',
                            style: GoogleFonts.quantico(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
