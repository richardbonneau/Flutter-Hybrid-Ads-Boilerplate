import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hybridadsboilerplate/Providers/Ads.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final ads = Provider.of<Ads>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          onPressed: ads.buyAds,
          child: Text("Pay to remove ads"),
        ),
        RaisedButton(
          onPressed: ads.undoBuyAds,
          child: Text("Put back ads"),
        ),
      ],
    );
  }
}
