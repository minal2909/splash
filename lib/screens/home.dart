import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash/Providers/themeProvider.dart';
import 'package:splash/constant.dart';
import 'package:splash/data/data.dart';
import 'package:splash/model/categories_model.dart';
import 'package:splash/model/wallpaper_model.dart';
import 'package:splash/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:splash/screens/search.dart';
import 'categories.dart';
import 'image_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<WallpaperModel> wallpaper = new List();
  int noOfImageToLoad = 80;
  TextEditingController searchEditingController = new TextEditingController();
  bool loading = true;

  void getTrendingWallpapers() async {
    http.Response response = await http.get(
        "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=1",
        headers: {"Authorization": apiKey});
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
    } else {
      print("user getting error");
    }

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      //print(element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpaper.add(wallpaperModel);
      //print(wallpaperModel.toString());
    });

    setState(() {});
  }

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    getTrendingWallpapers();

    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + 30;
        getTrendingWallpapers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      backgroundColor: !settingsProvider.darkTheme
          ? Color(0xff292929)
          : Colors.white, //DARK THEME HERE
      body: SingleChildScrollView(
        child: loading
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 170.0),
                child: SpinKitRing(
                  color: Color(0xff37474f),
                  size: 60.0,
                ),
              )
            : Container(
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
