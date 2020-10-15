import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:splash/Providers/themeProvider.dart';
import 'package:splash/data/data.dart';
import 'package:splash/model/categories_model.dart';
import 'package:splash/model/wallpaper_model.dart';
import 'package:splash/widgets/Mydemo.dart';
import 'package:splash/widgets/widget.dart';

class Popular extends StatefulWidget {
  final String categoryName;
  Popular(this.categoryName);

  List<CategoriesModel> getCategories() {
    List<CategoriesModel> categories = new List();
    CategoriesModel categoriesModel = new CategoriesModel();

    categoriesModel.catagoriesName = "Popular";
    categories.add(categoriesModel);
    categoriesModel = new CategoriesModel();

    return categories;
  }

  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  List<WallpaperModel> wallpaper = new List();
  bool loading = true;

  void getSearchWallpapers(String query) async {
    http.Response response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=80",
        headers: {"Authorization": apiKey});

    setState(() {
      loading = false;
    });

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      // print(element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpaper.add(wallpaperModel);
      //print(wallpaperModel.toString());
    });

    // setState(() {});
  }

  void initState() {
    getSearchWallpapers(widget.categoryName);
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(wallpaper.length);
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      child: Scaffold(
        backgroundColor: !settingsProvider.darkTheme
            ? Color(0xff292929)
            : Colors.white, //DARK THEME

        body: SingleChildScrollView(
          child: loading
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 300.0),
                  child: SpinKitRing(
                    color: Color(0xff37474f),
                    size: 60.0,
                  ),
                )
              : Container(
                  color: !settingsProvider.darkTheme
                      ? Color(0xff292929)
                      : Colors.white, //DARK THEME HERE
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
      ),
    );
  }
}
