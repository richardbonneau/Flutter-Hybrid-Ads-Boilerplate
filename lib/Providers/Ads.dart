import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Ads with ChangeNotifier {
  bool areAdsRemoved = false;
  List<IAPItem> _items = [];
  List<PurchasedItem> _purchases = [];

  fetchProductsList() async {
    List<IAPItem> items = [];
    try {
      if (Platform.isAndroid)
        items = await FlutterInappPurchase.instance
            .getProducts([DotEnv().env["ANDROID_AD_PRODUCT_ID"]]);
      else
        items = await FlutterInappPurchase.instance
            .getProducts([DotEnv().env["IOS_AD_PRODUCT_ID"]]);
    } catch (err) {
      print("getProducts error: $err");
    }
    for (var item in items) {
      print(item.toString());
      this._items.add(item);
    }
    _items = items;
    notifyListeners();
    checkAdsPurchasedStatus();
  }

  checkAdsPurchasedStatus() async {
    List<PurchasedItem> purchases = [];
    try {
      purchases = await FlutterInappPurchase.instance.getPurchaseHistory();
    } catch (err) {
      print("err in checkAdsPurchasedStatus: $err");
    }
    for (var item in purchases) {
//      print(item.toString());
      _purchases.add(item);
    }
    this._items = [];
//    print("_purchases length ${_purchases.length}");
    if (_purchases.length == 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool checkIfAdsArePurchased = await prefs.getBool('areAdsRemoved');
      if (checkIfAdsArePurchased == null)
        prefs.setBool("areAdsRemoved", false);
      else
        areAdsRemoved = checkIfAdsArePurchased;
//      print("here ${prefs.getBool('areAdsRemoved')}");
    } else
      areAdsRemoved = true;
    notifyListeners();
  }

  adsPurchased() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('areAdsRemoved', true);
    areAdsRemoved = true;
    notifyListeners();
  }

  undoBuyAds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('areAdsRemoved', false);
    areAdsRemoved = false;
    notifyListeners();
  }

  buyAds() {
    try {
      if (Platform.isAndroid)
        FlutterInappPurchase.instance
            .requestPurchase(DotEnv().env["ANDROID_AD_PRODUCT_ID"]);
      else
        FlutterInappPurchase.instance
            .requestPurchase(DotEnv().env["IOS_AD_PRODUCT_ID"]);
    } catch (err) {
      print("requestPurchase err: $err");
    }
//    areAdsRemoved = true;
    notifyListeners();
  }
}
