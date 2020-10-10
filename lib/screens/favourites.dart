import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash/Providers/themeProvider.dart';
import 'package:splash/data/utilities.dart';
import 'package:splash/model/wallpaper_model.dart';
import 'package:splash/screens/image_view.dart';
import 'package:splash/widgets/widget.dart';
import 'package:provider/provider.dart';
import 'image_view.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List<WallpaperModel> wallpaper = new List();
  List<Favourites> _favourites;

  @override
  void initState() {
    super.initState();
    getImages();
  }

  Future<void> getImages() async {
    Map<String, dynamic> jsonData;
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> imagesList = preferences.getStringList("FAVOURITES");
    for (int i = 0; i < imagesList.length; i++) {
      Map<String, dynamic> data;
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap({
        "photographerURL": "",
        "photographerID": "",
        "photographer": "",
        "src": {
          "portrait": imagesList[i],
          "large": " ",
          "landscape": " ",
          "medium": " "
        }
      });
      wallpaper.add(wallpaperModel);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    //var myDatabase = Provider.of<MyDatabase>(context);
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      backgroundColor: !settingsProvider.darkTheme
          ? Color(0xff292929)
          : Colors.white, //DARK THEME HERE
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 5.0,
              ),
              wallpaperList(wallpaper: wallpaper, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
