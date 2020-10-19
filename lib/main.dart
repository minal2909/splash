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

 const String testDevice='861646040148999';

void main() => runApp(ChangeNotifierProvider(
      create: (BuildContext context) => SettingsProvider(),
      child: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String> [testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Wallpaper'],
);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BannerAd _bannerAd;

  BannerAd createBannerAd(){
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: MyApp.targetingInfo,
      listener : (MobileAdEvent event){
        print("BannerAdd $event");
      }
    );
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
    _bannerAd= createBannerAd()..load()..show();

  super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
 }

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
