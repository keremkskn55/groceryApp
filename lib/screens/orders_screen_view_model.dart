import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app_firebase/model/order_model.dart';
import 'package:grocery_app_firebase/model/product_model.dart';
import 'package:grocery_app_firebase/services/database.dart';

class OrdersScreenViewModel with ChangeNotifier {
  String _collectionPathProduct = 'products';
  String _collectionPathOrder = 'orders';
  Database _database = Database();

  Stream<List<Product>> getProductList() {
    /// stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>
    Stream<List<DocumentSnapshot>> streamListDocument = _database
        .getProductListFromApi(_collectionPathProduct)
        .map((querySnapshot) => querySnapshot.docs);

    ///Stream<List<DocumentSnapshot>> --> Stream<List<Book>>
    Stream<List<Product>> streamListProduct = streamListDocument.map(
        (listOfDocSnap) => listOfDocSnap
            .map((docSnap) => Product.fromMap(docSnap.data() as Map))
            .toList());

    return streamListProduct;
  }

  Stream<List<Order>> getOrderList() {
    /// stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>
    Stream<List<DocumentSnapshot>> streamListDocument = _database
        .getProductListFromApi(_collectionPathOrder)
        .map((querySnapshot) => querySnapshot.docs);

    ///Stream<List<DocumentSnapshot>> --> Stream<List<Book>>
    Stream<List<Order>> streamListOrder = streamListDocument.map(
        (listOfDocSnap) => listOfDocSnap
            .map((docSnap) => Order.fromMap(docSnap.data() as Map))
            .toList());

    return streamListOrder;
  }
}
