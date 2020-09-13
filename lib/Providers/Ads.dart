import 'package:flutter/material.dart';
import 'dart:io';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

class Ads with ChangeNotifier {
  bool areAdsPurchased = false;
//  List<IAPItem> _items = [];
//  List<PurchasedItem> _purchases = [];
//
//  fetchProductsList() async {
//    List<IAPItem> items = [];
//    try {
//      if(Platform.isAndroid) items = await FlutterInappPurchase.instance.getProducts(['remove_ads']);
//      //TODO: put the actual ios product id here
//      else items = await FlutterInappPurchase.instance.getProducts(['remove_ads']);
//    }
//
//    catch (err) {
//      print("getProducts error: $err");
//    }
//    for (var item in items) {
////      print(item.toString());
//      this._items.add(item);
//    }
//    _items = items;
//    notifyListeners();
//    checkAdsPurchasedStatus();
//  }
//
//  checkAdsPurchasedStatus() async {
//    List<PurchasedItem> items = [];
//    try {
//      items = await FlutterInappPurchase.instance.getPurchaseHistory();
//    } catch (err) {
//      print("err in checkAdsPurchasedStatus: $err");
//    }
//    for (var item in items) {
////      print(item.toString());
//      _purchases.add(item);
//    }
//    this._items = [];
////    print("_purchases length ${_purchases.length}");
//    if (_purchases.length == 0) {
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      bool checkIfAdsArePurchased = await prefs.getBool('areAdsPurchased');
//      if (checkIfAdsArePurchased == null)
//        prefs.setBool("areAdsPurchased", false);
//      else
//        areAdsPurchased = checkIfAdsArePurchased;
////      print("here ${prefs.getBool('areAdsPurchased')}");
//    } else
//      areAdsPurchased = true;
//    notifyListeners();
//  }
//
//  adsPurchased() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    await prefs.setBool('areAdsPurchased', true);
//    areAdsPurchased = true;
//    notifyListeners();
//  }
//
  undoBuyAds() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    await prefs.setBool('areAdsPurchased', false);
    areAdsPurchased = false;
    notifyListeners();
  }

  buyAds() {
    areAdsPurchased = true;

//    print("in buy ads");
//    try {
//      FlutterInappPurchase.instance.requestPurchase("remove_ads");
//    } catch (err) {
//      print("requestPurchase err: $err");
//    }
    notifyListeners();
  }
}
