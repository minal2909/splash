import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash/Providers/themeProvider.dart';
import 'package:splash/components/body.dart';
import 'package:splash/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    //have to call it on starting screen
    var settingsProvider = Provider.of<SettingsProvider>(context);
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: !settingsProvider.darkTheme
          ? Color(0xff292929)
          : Colors.white, //DARK THEME here
      body: Body(),
    );
  }
}
