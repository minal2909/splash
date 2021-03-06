import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:splash/screens/splash_screen.dart';
import 'Providers/themeProvider.dart';
import 'constant.dart';
import 'routs.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:provider/provider.dart';
import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = '865166044909177';

void main() => runApp(ChangeNotifierProvider(
      create: (BuildContext context) => SettingsProvider(),
      child: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //   testDevices: testDevice != null ? <String>[testDevice] : null,
  //   nonPersonalizedAds: true,
  //   keywords: <String>['wallpaper'],
  // );

  // BannerAd _bannerAd;
  // InterstitialAd _interstitialAd;

  // BannerAd createBannerAd() {
  //   return BannerAd(
  //       //"ca-app-pub-9225677675721132/7219010316"
  //       adUnitId: "ca-app-pub-9225677675721132/7219010316",
  //       //Change BannerAd adUnitId with Admob ID
  //       size: AdSize.banner,
  //       targetingInfo: targetingInfo,
  //       listener: (MobileAdEvent event) {
  //         print("BannerAd $event");
  //       });
  // }

  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: [testDevice],
    keywords: <String>['wallpapers'],
    childDirected: false,
  );

  BannerAd myBanner = BannerAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    adUnitId: "ca-app-pub-3940256099942544/6300978111",
    size: AdSize.smartBanner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );

  @override
  void initState() {
    myBanner
      ..load()
      ..show(
        anchorOffset: -11.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
  }
  //   FirebaseAdMob.instance
  //       .initialize(appId: "ca-app-pub-9225677675721132~5586364440");
  //   //Change appId With Admob Id
  //   _bannerAd = createBannerAd()
  //     ..load()
  //     ..show(
  //       anchorOffset: 10.0,
  //     );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Incredible 4K wallpapers 2020',
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
          backgroundColor: Color(0xff292929),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "mulish",
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            bodyText1: TextStyle(color: kTextColor),
            bodyText2: TextStyle(color: kTextColor),
          )),
      //home: SplashScreen(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
