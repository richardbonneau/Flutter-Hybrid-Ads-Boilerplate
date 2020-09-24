import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hybridadsboilerplate/Providers/Ads.dart';

class BottomBannerAd extends StatelessWidget {
  const BottomBannerAd({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ads = Provider.of<Ads>(context);
    double actualDeviceWidth = MediaQuery.of(context).size.width;
    print(ads.areAdsRemoved);
    return ads.areAdsRemoved
        ? Container(
            height: 0,
          )
        : AdmobBanner(
            adUnitId: DotEnv().env["BANNER_ID"],
            adSize: actualDeviceWidth > 730
                ? AdmobBannerSize.LEADERBOARD
                : actualDeviceWidth > 468
                    ? AdmobBannerSize.FULL_BANNER
                    : AdmobBannerSize.BANNER,
          );
  }
}
