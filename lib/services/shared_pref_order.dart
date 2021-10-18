import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefOrder with ChangeNotifier {
  static late SharedPreferences _sharedPreferences;
  List<String> _myOrders = [];

  void addOrder(String orderIdNum) {
    _myOrders.add(orderIdNum);
    saveOrdersToSharedPref(myOrders);
    notifyListeners();
  }

  UnmodifiableListView<String> get myOrders => UnmodifiableListView(_myOrders);

  Future<void> createPrefObject() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> clearData() async {
    await _sharedPreferences.clear();
  }

  void saveOrdersToSharedPref(List<String> myOrders) {
    _sharedPreferences.setStringList('orders', myOrders);
  }

  void loadOrdersFromSharedPref() {
    List<String> tempList = _sharedPreferences.getStringList('orders') ?? [];
    print('tempList:$tempList');
    _myOrders.clear();
    for (var item in tempList) {
      _myOrders.add(item);
    }
  }
}
