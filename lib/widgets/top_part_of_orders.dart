import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopPartOfOrders extends StatelessWidget {
  const TopPartOfOrders({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
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
            child: Center(
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
        Text(
          'ORDERS',
          style: GoogleFonts.quantico(fontSize: 24, color: Colors.black),
        ),
        Container(
          margin: EdgeInsets.all(16),
          width: 50,
          height: 50,
        ),
      ],
    );
  }
}
