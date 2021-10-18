import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app_firebase/model/product_model.dart';

class SearchScreen extends StatefulWidget {
  List<Product>? productList;
  SearchScreen({required this.productList});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  bool isFiltering = false;
  List<Product>? filteredList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var fullList = widget.productList;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height / 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFCBFFEF),
                    Colors.white,
                  ],
                ),
              ),
            ),
            Positioned(
              child: Container(
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    Row(
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
                          'SEARCH',
                          style: GoogleFonts.quantico(
                              fontSize: 24, color: Colors.black),
                        ),
                        Container(
                          margin: EdgeInsets.all(16),
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                    Container(
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
                      child: TextField(
                        style: TextStyle(fontSize: 16),
                        controller: _searchController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            hintText: 'SEARCH FRESH FOOD',
                            hintStyle: TextStyle(color: Colors.black)),
                        onChanged: (query) {
                          if (query.isNotEmpty) {
                            setState(() {
                              isFiltering = true;
                              filteredList = fullList!
                                  .where((product) => product.name
                                      .toLowerCase()
                                      .contains(query.toLowerCase()))
                                  .toList();
                            });
                          } else {
                            setState(() {
                              isFiltering = false;
                            });
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: isFiltering
                              ? filteredList!.length
                              : fullList!.length,
                          itemBuilder: (context, index) {
                            Size size = MediaQuery.of(context).size;
                            return Container(
                              margin: EdgeInsets.only(
                                  top: 12, bottom: 12, left: 24, right: 24),
                              width: size.width - 48,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFFE8E8E8),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  bottomRight: Radius.circular(24),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: AnimatedSwitcher(
                                  duration: Duration(seconds: 1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 12),
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Color(isFiltering
                                                  ? filteredList![index]
                                                      .colorNum
                                                  : fullList![index].colorNum)
                                              .withOpacity(0.55),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(isFiltering
                                                ? filteredList![index].photoUrl
                                                : fullList![index].photoUrl),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            isFiltering
                                                ? filteredList![index].name
                                                : fullList![index].name,
                                            style: GoogleFonts.quantico(
                                              fontSize: 16,
                                              color: Color(isFiltering
                                                  ? filteredList![index]
                                                      .colorNum
                                                  : fullList![index].colorNum),
                                            ),
                                          ),
                                          Text(
                                            isFiltering
                                                ? filteredList![index].type
                                                : fullList![index].type,
                                            style: GoogleFonts.quantico(
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '${((isFiltering ? filteredList![index].price : fullList![index].price) - (isFiltering ? filteredList![index].price : fullList![index].price).remainder(1)).round()}',
                                                  style: GoogleFonts.quantico(
                                                      fontSize: 16,
                                                      color: Colors.green)),
                                              TextSpan(
                                                  text:
                                                      '.${((isFiltering ? filteredList![index].price : fullList![index].price).remainder(1) == 0 ? 00 : (isFiltering ? filteredList![index].price : fullList![index].price).remainder(1) * 100).round()} \$',
                                                  style: GoogleFonts.quantico(
                                                      fontSize: 12,
                                                      color: Colors.green)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
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
