import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app_firebase/model/order_model.dart';
import 'package:grocery_app_firebase/model/product_model.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getProductListFromApi(String referencePath) {
    return _firestore.collection(referencePath).snapshots();
  }

  Future<void> setOrderData(
      {required String collectionPath,
      required Map<String, dynamic> orderAsMap}) async {
    _firestore
        .collection(collectionPath)
        .doc(Order.fromMap(orderAsMap).idNum)
        .set(orderAsMap);
  }
}
