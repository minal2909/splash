import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splash/components/theme_toggle.dart';
import 'package:splash/constant.dart';
import 'package:splash/model/wallpaper_model.dart';
import 'package:splash/size_config.dart';
import 'package:splash/screens/image_view.dart';

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
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                Text(
                  "Incredible 4K wallpapers 2020",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      color: !darkTheme
                          ? Colors.white
                          : Colors
                              .black, //DARK THEME HERE--------------------------------------
                      fontWeight: FontWeight.bold,
                      fontFamily: "mulish"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: IconButton(
                    onPressed: () {
                      Menu();
                    },
                    icon: Icon(
                      Icons.menu,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                )
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

  @override
  Widget build(BuildContext context) {
    onMenuPressed() {
      DropdownButton(
        underline: SizedBox(),
        value: _value,
        items: [
          DropdownMenuItem(
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 35,
                  child: CrazySwitch(),
                ),
                Text("Theme"),
              ],
            ),
            value: 1,
          ),
          DropdownMenuItem(
            child: Row(
              children: [
                Icon(Icons.arrow_forward_ios),
                Text("Terms and Condition"),
              ],
            ),
            value: 2,
          ),
          DropdownMenuItem(
            child: Row(
              children: [
                Icon(Icons.arrow_forward_ios),
                Text("Terms and Condition"),
              ],
            ),
            value: 3,
          )
        ],
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
      );
    }
  }
}
