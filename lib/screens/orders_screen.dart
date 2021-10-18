import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app_firebase/model/order_model.dart';
import 'package:grocery_app_firebase/model/product_model.dart';
import 'package:grocery_app_firebase/services/shared_pref_order.dart';
import 'package:grocery_app_firebase/widgets/categories.dart';
import 'package:grocery_app_firebase/widgets/top_part_of_orders.dart';
import 'package:provider/provider.dart';

import 'orders_screen_view_model.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isCurrent = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(Provider.of<SharedPrefOrder>(context).myOrders);
    return SafeArea(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => OrdersScreenViewModel()),
        ],
        builder: (context, _) => Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              /// Background Image
              Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images_components/order_background.png'),
                    fit: BoxFit.fitWidth,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  ),
                ),
              ),
              Container(
                width: size.width,
                height: size.height,
                child: OrderComponent(
                  isCurrent: isCurrent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderComponent extends StatefulWidget {
  bool isCurrent;
  OrderComponent({required this.isCurrent});

  @override
  _OrderComponentState createState() => _OrderComponentState();
}

class _OrderComponentState extends State<OrderComponent> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        /// Top Part
        TopPartOfOrders(),

        /// Category Part Of Orders
        categoryPartOfOrders(size),

        /// SizedBox
        SizedBox(
          height: 10,
        ),

        /// Lists Of Orders
        Expanded(
          child: StreamBuilder<List<Product>>(
            stream: Provider.of<OrdersScreenViewModel>(context, listen: false)
                .getProductList(),
            builder: (context, asyncSnapshot_1) {
              if (asyncSnapshot_1.hasError) {
                return Center(
                  child: Text('There are an error'),
                );
              } else {
                if (!asyncSnapshot_1.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  List<Product>? productList = asyncSnapshot_1.data;
                  return StreamBuilder<List<Order>>(
                    stream: Provider.of<OrdersScreenViewModel>(context,
                            listen: false)
                        .getOrderList(),
                    builder: (context, asyncSnapshot_2) {
                      if (asyncSnapshot_2.hasError) {
                        return Center(
                          child: Text('There are an error'),
                        );
                      } else {
                        if (!asyncSnapshot_2.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          List<Order>? orderList = asyncSnapshot_2.data;
                          if (Provider.of<SharedPrefOrder>(context)
                              .myOrders
                              .isEmpty) {
                            return Center(
                              child: Text(
                                'There is no order',
                                style: GoogleFonts.quantico(fontSize: 24),
                              ),
                            );
                          }
                          return ListOfOrdersWidget(
                            productList: productList,
                            orderList: orderList,
                            isCurrent: widget.isCurrent,
                          );
                        }
                      }
                    },
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }

  Row categoryPartOfOrders(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              widget.isCurrent = true;
            });
          },
          child: Container(
            height: 48,
            width: size.width / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(24)),
              color: widget.isCurrent
                  ? Colors.green
                  : Colors.green.withOpacity(0.5),
            ),
            child: Center(
              child: Text(
                'CURRENT',
                style: GoogleFonts.quantico(fontSize: 20),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              widget.isCurrent = false;
            });
          },
          child: Container(
            height: 48,
            width: size.width / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(24)),
              color: !widget.isCurrent
                  ? Colors.green
                  : Colors.green.withOpacity(0.5),
            ),
            child: Center(
              child: Text(
                'OLD',
                style: GoogleFonts.quantico(fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ListOfOrdersWidget extends StatefulWidget {
  List<Product>? productList;
  List<Order>? orderList;
  bool isCurrent;
  ListOfOrdersWidget(
      {required this.orderList,
      required this.productList,
      required this.isCurrent});

  @override
  _ListOfOrdersWidgetState createState() =>
      _ListOfOrdersWidgetState(orderList: orderList, productList: productList);
}

class _ListOfOrdersWidgetState extends State<ListOfOrdersWidget> {
  List<Product>? productList;
  List<Order>? orderList;

  _ListOfOrdersWidgetState(
      {required this.productList, required this.orderList});

  List<Order>? myOrderList = [];
  void myProductListCreate() {
    print('before foor loops for my Order');
    myOrderList = [];
    for (Order order in widget.orderList!) {
      for (String myOrderIdNum
          in Provider.of<SharedPrefOrder>(context, listen: false).myOrders) {
        if (order.idNum == myOrderIdNum) {
          if (widget.isCurrent) {
            if (!order.isApproval || !order.isDelivered) {
              myOrderList!.add(order);
            }
          } else {
            if (order.isApproval || order.isDelivered) {
              myOrderList!.add(order);
            }
          }
        }
      }
    }
  }

  @override
  void initState() {
    myProductListCreate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('before check length of my Order List');
    print('my Order List Length: ${myOrderList!.length}');
    print('first order: ${myOrderList![0].orderOfCustomer}');
    print('hello');
    return ListView.builder(
      itemCount: myOrderList!.length,
      itemBuilder: (context, index) {
        List currentProcessOrderProductIdList = [];
        List currentProcessOrderProductNumberList = [];
        List currentProductColorNum = [];
        List currentProductPhotoUrl = [];
        Order currentProcessOrder = myOrderList![index];
        for (var productIdNum in currentProcessOrder.orderOfCustomer.keys) {
          currentProcessOrderProductIdList.add(productIdNum);
          currentProcessOrderProductNumberList
              .add(currentProcessOrder.orderOfCustomer[productIdNum]);
          print('loop 3.= $productIdNum');
          for (Product product in productList!) {
            if (product.idNum.toString() == productIdNum) {
              currentProductColorNum.add(product.colorNum);
              currentProductPhotoUrl.add(product.photoUrl);
            }
          }
        }
        print('control point 6');

        return SizedBox(
          width: size.width,
          height: 300,
          child: Container(
            margin: EdgeInsets.all(24),
            padding: EdgeInsets.all(12),
            width: size.width - 48,
            height: 348,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.grey,
                  ),
                  child: Text(
                    '${currentProcessOrder.name} ${currentProcessOrder.surname}',
                    style: GoogleFonts.quantico(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 50,
                  width: size.width - 48,
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: currentProcessOrderProductIdList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          width: 90,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.grey.withOpacity(0.8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: Color(currentProductColorNum[index]),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        currentProductPhotoUrl[index]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: 40,
                                child: Center(
                                  child: Text(
                                    '${currentProcessOrderProductNumberList[index]}',
                                    style: GoogleFonts.quantico(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.grey.withOpacity(0.6),
                  ),
                  child: Text(
                    '${currentProcessOrder.address}',
                    style: GoogleFonts.quantico(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.grey.withOpacity(0.4),
                  ),
                  child: Text(
                    '${currentProcessOrder.note}',
                    style: GoogleFonts.quantico(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
