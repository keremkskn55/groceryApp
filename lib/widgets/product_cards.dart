import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app_firebase/model/product_model.dart';
import 'package:grocery_app_firebase/screens/selling_screen.dart';

class ProductCards extends StatefulWidget {
  final Size size;
  final Product product;
  Map<Product, int> boughtProductMap;
  ProductCards({
    required this.size,
    required this.product,
    required this.boughtProductMap,
  });

  @override
  _ProductCardsState createState() => _ProductCardsState();
}

class _ProductCardsState extends State<ProductCards> {
  @override
  Widget build(BuildContext context) {
    String nameOfProduct = widget.product.name;
    String typeOfProduct = widget.product.type;
    double priceOfproduct = widget.product.price;
    String photoUrl = widget.product.photoUrl;
    int colorNum = widget.product.colorNum;

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Container(
            width: (widget.size.width * 3) / 6,
            height: (widget.size.height * 3) / 8,
            decoration: BoxDecoration(
              color: Color(0xFFE8E8E8),
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
            ),
          ),
          Container(
            height: 24,
            width: (widget.size.width * 3) / 6,
            decoration: BoxDecoration(
              color: Color(colorNum),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
          ),
          Positioned(
            top: 24,
            child: Container(
              width: (widget.size.width * 3) / 6,
              height: (widget.size.width * 3) / 12,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(colorNum),
                    Color(colorNum),
                    Color(0xFFE8E8E8),
                    Color(0xFFE8E8E8),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular((widget.size.width * 3) / 12),
                  bottomRight: Radius.circular((widget.size.width * 3) / 12),
                ),
              ),
            ),
          ),
          Positioned(
            left: (widget.size.width) / 12,
            right: (widget.size.width) / 12,
            top: (widget.size.height) / 24,
            child: Image(
              image: NetworkImage(photoUrl),
              height: (widget.size.width * 2) / 6,
              width: (widget.size.width * 3) / 12,
            ),
          ),
          Positioned(
            left: (widget.size.width * 2) / 6,
            top: ((widget.size.height * 3) / 8) - ((widget.size.width) / 6),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SellingScreen(
                              product: widget.product,
                              boughtProductMap: widget.boughtProductMap,
                            )));
              },
              child: Container(
                width: (widget.size.width) / 6,
                height: (widget.size.width) / 6,
                decoration: BoxDecoration(
                  color: Color(colorNum).withOpacity(0.55),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 36,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: (widget.size.height / 20) + ((2 * widget.size.width) / 6) - 20,
            child: Text(
              nameOfProduct.toUpperCase(),
              style: GoogleFonts.quantico(
                fontSize: 20,
                color: Color(colorNum),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: (widget.size.height / 20) + ((2 * widget.size.width) / 6),
            child: Text(
              typeOfProduct.toUpperCase(),
              style: GoogleFonts.quantico(
                fontSize: 16,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: (widget.size.height * 3) / 8 - 36,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text:
                          '${(priceOfproduct - priceOfproduct.remainder(1)).round()}',
                      style: GoogleFonts.quantico(
                          fontSize: 20, color: Colors.green)),
                  TextSpan(
                    text:
                        '.${(priceOfproduct.remainder(1) == 0 ? 00 : priceOfproduct.remainder(1) * 100).round()} \$',
                    style:
                        GoogleFonts.quantico(fontSize: 16, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
