import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash/Providers/themeProvider.dart';

class CrazySwitch extends StatefulWidget {
  @override
  _CrazySwitchState createState() => _CrazySwitchState();
}

class _CrazySwitchState extends State<CrazySwitch> {
  bool isDark = false;

  // var _isDark = prefs.getString("theme").toLowerCase();

  // @override
  // void initState() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var _isDark = prefs.getString("theme").toLowerCase();
  //   setState(() {
  //     isDark = _isDark.toLowerCase() == 'true' ? true : false;
  //   });
  //   super.initState();
  // }
  upadteTheme(setTheme) {
    setTheme(!isDark);
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    // print(isChecked);
    return Container(
      height: 44,
      width: 60,
      child: Scaffold(
        body: Switch(
          value: !settingsProvider.darkTheme,
          onChanged: (value) {
            upadteTheme(settingsProvider.setTheme);
          },
          // activeTrackColor: Colors.lightGreenAccent,
          activeColor: Color(0xff292929),
        ),
      ),
    );
  }
}
