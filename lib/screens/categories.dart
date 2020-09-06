import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:splash/data/data.dart';
import 'package:splash/model/wallpaper_model.dart';
import 'package:splash/widgets/widget.dart';

class Categories extends StatefulWidget {
  final String categoryName;
  Categories({this.categoryName});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<WallpaperModel> wallpaper = new List();

  void getSearchWallpapers(String query) async {
    http.Response response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=80",
        headers: {"Authorization": apiKey});

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

  @override
  void initState() {
    getSearchWallpapers(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: AppName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 16.0,
              ),
              wallpaperList(wallpaper: wallpaper, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
