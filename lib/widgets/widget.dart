import 'package:flutter/material.dart';
import 'package:splash/constant.dart';
import 'package:splash/model/wallpaper_model.dart';
import 'package:splash/size_config.dart';

Widget AppName() {
  return Hero(
    tag: "appTitle",
    child: Text(
      "Splash",
      style: TextStyle(
        fontSize: getProportionateScreenWidth(25),
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget wallpaperList({List<WallpaperModel> wallpaper, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpaper.map((wallpaper) {
        return GridTile(
          child: Container(
            child: Image.network(wallpaper.src.portrait),
          ),
        );
      }).toList(),
    ),
  );
}
