import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:hybridadsboilerplate/Providers/Ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hybridadsboilerplate/Components/BottomBannerAd.dart';
import 'package:hybridadsboilerplate/Screens/Home.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Ads>(
            create: (context) => Ads(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Home(title: 'Hybrid Ads Boiler Plate'),
        ));
  }
}

class IapSetup extends StatefulWidget {
  IapSetup(Key key) : super(key: key);
  _IapSetupState createState() => _IapSetupState();
}

class _IapSetupState extends State<IapSetup> {
  StreamSubscription _purchaseUpdatedSubscription;
  StreamSubscription _purchaseErrorSubscription;
  StreamSubscription _connectionSubscription;
  var _result = "";
  bool purchaseUpdated = false;
  void initState() {
    super.initState();
    _initializePlatformState();
  }

  Future<void> _initializePlatformState() async {
    var result = await FlutterInappPurchase.instance.initConnection;
    setState(() {
      _result = result;
    });
    if (!mounted) return;

    // refresh items for android
    try {
      String msg = await FlutterInappPurchase.instance.consumeAllItems;
      print("consumeAllItems: $msg");
    } catch (err) {
      print("consukeAllItems error: $err");
    }
    _connectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
      print("connected: $connected");
    });

    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      setState(() {
        purchaseUpdated = true;
      });
//      print("purchase updated: $productItem");
    });

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print("purchase error: $purchaseError");
    });
  }

  void dispose() async {
    super.dispose();
    if (_connectionSubscription != null) {
      _connectionSubscription.cancel();
      _connectionSubscription = null;
    }
    if (_purchaseErrorSubscription != null) {
      _purchaseErrorSubscription.cancel();
      _purchaseErrorSubscription = null;
    }
    if (_purchaseUpdatedSubscription != null) {
      _purchaseUpdatedSubscription.cancel();
      _purchaseUpdatedSubscription = null;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Hybrid Ads Boilerplate"),
        ),
        bottomNavigationBar: BottomBannerAd(),
        body: Home());
  }
}
