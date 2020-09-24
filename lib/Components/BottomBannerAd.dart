import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BottomBannerAd extends StatelessWidget {
  const BottomBannerAd({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double actualDeviceWidth = MediaQuery.of(context).size.width;
    return AdmobBanner(
      adUnitId: DotEnv().env["BANNER_ID"],
      adSize: actualDeviceWidth > 730
          ? AdmobBannerSize.LEADERBOARD
          : actualDeviceWidth > 468
              ? AdmobBannerSize.FULL_BANNER
              : AdmobBannerSize.BANNER,
    );
  }
}
