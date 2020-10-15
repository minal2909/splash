import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash/Providers/themeProvider.dart';
import 'package:splash/components/theme_toggle.dart';
import 'package:splash/constant.dart';
import 'package:splash/model/wallpaper_model.dart';
import 'package:splash/size_config.dart';
import 'package:splash/screens/image_view.dart';
import 'package:splash/screens/t&c.dart';
import 'package:splash/screens/privacyPolicy.dart';

Widget AppName(bool darkTheme) {
  List<String> menu = [
    "Theme change",
    "Terms and Condition",
    "Privacy policy",
  ];

  return Hero(
    tag: "appTitle",
    transitionOnUserGestures: true,
    child: Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          color:
              !darkTheme ? Color(0xff292929) : Colors.white, //DARK THEME HERE
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Image.asset(
                    "images/appIcon.jpeg",
                    height: 35,
                    width: 35,
                  ),
                ),
                SizedBox(
                  width: 18.0,
                ),
                Container(
                  child: Text(
                    "Incredible wallpapers",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        color: !darkTheme
                            ? Colors.white
                            : Colors
                                .black, //DARK THEME HERE--------------------------------------
                        fontWeight: FontWeight.bold,
                        fontFamily: "mulish"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Menu(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget wallpaperList({List<WallpaperModel> wallpaper, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: wallpaper.map((wallpaper) {
          return GridTile(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ImageView(imgURL: wallpaper.src.portrait);
                  }));
                },
                child: Hero(
                  tag: wallpaper.src.portrait,
                  child: Container(
                    child: Image.network(
                      wallpaper.src.portrait,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList()),
  );
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _value = 1;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return PopupMenuButton(
      icon: Icon(
        Icons.menu,
        color: !settingsProvider.darkTheme ? Colors.white : Colors.black,
        size: 40.0,
      ),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: CrazySwitch(),
                ),
                Text("Theme"),
              ],
            ),
            value: 1,
          ),
          PopupMenuItem(
            child: Divider(
              height: 10,
              thickness: 2,
            ),
            value: 1.5,
          ),
          PopupMenuItem(
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TermsAndCondition();
                }));
              },
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 10.0,
                    ),
                    Text("Terms and Condition"),
                  ],
                ),
              ),
            ),
            value: 2,
          ),
          PopupMenuItem(
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PrivacyPolicy();
                }));
              },
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 10.0,
                    ),
                    Text("Privacy Policy"),
                  ],
                ),
              ),
            ),
            value: 3,
          )
        ];
      },
      onSelected: (value) {
        print(value);
        setState(() {
          _value = 1;
        });
      },
    );
  }
}
