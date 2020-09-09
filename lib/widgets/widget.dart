import 'package:flutter/material.dart';
import 'package:splash/constant.dart';
import 'package:splash/model/wallpaper_model.dart';
import 'package:splash/size_config.dart';
import 'package:splash/screens/image_view.dart';

Widget AppName() {
  return Hero(
    tag: "appTitle",
    transitionOnUserGestures: true,
    child: Material(
      type: MaterialType.transparency,
      child: Center(
        child: Text(
          "Splash",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(25),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
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
                    return ImageView(
                      imgURL: wallpaper.src.portrait,
                    );
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
