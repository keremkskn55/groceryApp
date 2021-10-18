import 'package:flutter/material.dart';
import 'package:grocery_app_firebase/model/order_model.dart';
import 'package:grocery_app_firebase/services/database.dart';

class FinishingShoppingScreenViewModel with ChangeNotifier {
  Database _database = Database();
  String collectionPath = 'orders';

  Future<void> addNewOrder({
    required String name,
    required String surname,
    required String address,
    required String note,
    required Map orderOfCustomer,
    required String idNum,
  }) async {
    /// Form alanındaki verileri ile önce bir book objesi oluşturulması
    Order newOrder = Order(
      idNum: idNum,
      name: name,
      surname: surname,
      address: address,
      note: note,
      orderOfCustomer: orderOfCustomer,
      isDelivered: false,
      isApproval: false,
    );

    /// bu kitap bilgisini database servisi üzerinden Firestore'a yazacak
    await _database.setOrderData(
        collectionPath: collectionPath, orderAsMap: newOrder.toMap());
  }
}
