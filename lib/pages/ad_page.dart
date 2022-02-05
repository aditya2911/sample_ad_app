import 'package:flutter/material.dart';
import 'package:flutter_applovin_max/banner.dart';
import 'package:flutter_applovin_max/flutter_applovin_max.dart';

class addPage extends StatefulWidget {
  const addPage({Key? key}) : super(key: key);

  @override
  _addPageState createState() => _addPageState();
}

class _addPageState extends State<addPage> {
  String BANNER_AD_UNIT_ID = '5c4895b40e31852e';
  String INTERSTITIAL_AD_UNIT_ID = 'b73fe0ac42595034';

  @override
  void initState() {
    FlutterApplovinMax.initSDK();
    FlutterApplovinMax.initInterstitialAd(INTERSTITIAL_AD_UNIT_ID);

    // TODO: implement initState
    super.initState();
  }

  void listener(AppLovinAdListener? event) {
    if (event == AppLovinAdListener.adDisplayed) {
      print('get reward');
    }
  }

  bool isRewardedVideoAvailable = false;
  bool isInterstitialVideoAvailable = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: [
            const Spacer(),
            TextButton(
              onPressed: () async {
                isInterstitialVideoAvailable =
                    (await FlutterApplovinMax.isInterstitialLoaded(listener))!;
                if (isInterstitialVideoAvailable) {
                  FlutterApplovinMax.showInterstitialVideo(
                      (AppLovinAdListener? event) => listener(event));
                }
              },
              child: const Text('Show Interstitial Video'),
            ),
            const Spacer(),
          ],
        )),
        bottomNavigationBar: BannerMaxView(
            (AppLovinAdListener? event) => print(event),
            BannerAdSize.banner,
            BANNER_AD_UNIT_ID),
      ),
    );
  }
}
