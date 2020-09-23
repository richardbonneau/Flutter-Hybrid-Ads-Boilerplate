import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hybridadsboilerplate/Providers/Ads.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:hybridadsboilerplate/Components/BottomBannerAd.dart';

void main() async {
  await FlutterConfig.loadEnvVariables();
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
          home: MyHomePage(title: 'Hybrid Ads Boiler Plate'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final ads = Provider.of<Ads>(context);
    print(FlutterConfig.get("BANNER_ID"));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
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
            BottomBannerAd()
          ],
        ),
      ),
    );
  }
}
