import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatefulWidget {
  Function callback;

  Categories({required this.callback});
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int currentCategories = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.callback(0);
                    currentCategories = 0;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      'ALL',
                      style: GoogleFonts.quantico(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: currentCategories == 0
                            ? Colors.green
                            : Colors.black,
                      ),
                    ),
                    Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        color: currentCategories == 0
                            ? Colors.green
                            : Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(3.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  print('fruits');
                  setState(() {
                    widget.callback(1);
                    currentCategories = 1;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      'FRUITS',
                      style: GoogleFonts.quantico(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: currentCategories == 1
                            ? Colors.green
                            : Colors.black,
                      ),
                    ),
                    Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        color: currentCategories == 1
                            ? Colors.green
                            : Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(3.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.callback(2);
                    currentCategories = 2;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      'VEGETABLES',
                      style: GoogleFonts.quantico(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: currentCategories == 2
                            ? Colors.green
                            : Colors.black,
                      ),
                    ),
                    Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        color: currentCategories == 2
                            ? Colors.green
                            : Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(3.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.callback(3);
                    currentCategories = 3;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      'DAIRY',
                      style: GoogleFonts.quantico(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: currentCategories == 3
                            ? Colors.green
                            : Colors.black,
                      ),
                    ),
                    Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        color: currentCategories == 3
                            ? Colors.green
                            : Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(3.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
