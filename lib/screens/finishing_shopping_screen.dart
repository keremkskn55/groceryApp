import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app_firebase/model/product_model.dart';
import 'package:grocery_app_firebase/screens/finishing_shopping_screen_view_model.dart';
import 'package:grocery_app_firebase/screens/main_screen.dart';
import 'package:grocery_app_firebase/services/shared_pref_order.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class FinishingShoppingScreen extends StatefulWidget {
  Map<Product, int> boughtProductMap;
  FinishingShoppingScreen({required this.boughtProductMap});

  @override
  _FinishingShoppingScreenState createState() =>
      _FinishingShoppingScreenState();
}

class _FinishingShoppingScreenState extends State<FinishingShoppingScreen> {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController surnameCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
  TextEditingController noteCtr = TextEditingController();

  List<Product> boughtProductList = [];
  Map orderOfCustomer = {};

  var uuid = Uuid();
  late String idNumOfOrder;

  @override
  void initState() {
    idNumOfOrder = uuid.v1();
    boughtProductList.clear();
    setState(() {
      for (var element in widget.boughtProductMap.keys) {
        boughtProductList.add(element);
        orderOfCustomer[element.idNum.toString()] =
            widget.boughtProductMap[element];
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => FinishingShoppingScreenViewModel()),
      ],
      builder: (context, _) => SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images_components/background_details.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Column(
                children: [
                  /// Top Materials
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
                        'DETAILS',
                        style: GoogleFonts.quantico(
                            fontSize: 24, color: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          if (nameCtr.text.isEmpty ||
                              surnameCtr.text.isEmpty ||
                              addressCtr.text.isEmpty) {
                            print('Please Full All Area');
                          } else {
                            Provider.of<FinishingShoppingScreenViewModel>(
                                    context,
                                    listen: false)
                                .addNewOrder(
                                    idNum: idNumOfOrder,
                                    name: nameCtr.text,
                                    surname: surnameCtr.text,
                                    address: addressCtr.text,
                                    note: noteCtr.text,
                                    orderOfCustomer: orderOfCustomer);
                            Provider.of<SharedPrefOrder>(context, listen: false)
                                .addOrder(idNumOfOrder);
                            widget.boughtProductMap.clear();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainScreen()),
                                (route) => false);
                          }
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
                              Icons.done,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// Detail Page
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          /// Name Surname
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: TextField(
                                    controller: nameCtr,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.withOpacity(0.5),
                                      labelText: 'Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          bottomRight: Radius.circular(24),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: TextField(
                                    controller: surnameCtr,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.withOpacity(0.5),
                                      labelText: 'Surname',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          bottomRight: Radius.circular(24),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              controller: addressCtr,
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.5),
                                labelText: 'Address',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    bottomRight: Radius.circular(24),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              controller: noteCtr,
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.5),
                                labelText: 'Note',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    bottomRight: Radius.circular(24),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      height: 10,
                      color: Colors.black,
                      thickness: 3,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: boughtProductList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.only(left: 16, top: 16, bottom: 16),
                          width: size.width - 48,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFE8E8E8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 12),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color:
                                        Color(boughtProductList[index].colorNum)
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
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.grey),
                                  child: Center(
                                    child: Text(
                                      '${widget.boughtProductMap[boughtProductList[index]]}',
                                      style: GoogleFonts.quantico(fontSize: 16),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12.0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                                '${(boughtProductList[index].price - boughtProductList[index].price.remainder(1)).round()}',
                                            style: GoogleFonts.quantico(
                                                fontSize: 16,
                                                color: Colors.green)),
                                        TextSpan(
                                            text:
                                                '.${(boughtProductList[index].price.remainder(1) == 0 ? 00 : boughtProductList[index].price.remainder(1) * 100).round()} \$',
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
