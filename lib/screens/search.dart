import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash/Providers/themeProvider.dart';
import 'package:splash/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:splash/data/data.dart';
import 'package:splash/model/wallpaper_model.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import '../size_config.dart';

class Search extends StatefulWidget {
  static String routeName = "/search";
  final String searchQuery;
  Search({this.searchQuery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchEditingController = new TextEditingController();
  List<WallpaperModel> wallpaper = new List();
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<WallpaperModel>> key = new GlobalKey();
  bool loading = true;

  getSearchWallpapers(String query) async {
    http.Response response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=80",
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

  @override
  void initState() {
    getSearchWallpapers(widget.searchQuery);
    super.initState();
    searchEditingController.text = widget.searchQuery;
  }

  void _handleSubmitted(String value) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Search(
        searchQuery: value,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        backgroundColor: !settingsProvider.darkTheme
            ? Color(0xff292929)
            : Colors.white, //DARK THEME HERE
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: !settingsProvider.darkTheme
              ? Color(0xff292929)
              : Colors.white, //DARK THEME HERE
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: !settingsProvider.darkTheme
                      ? Colors.white
                      : Colors
                          .black, //DARK THEME HERE------------------------------
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text(
                  "Search",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(25),
                      color: !settingsProvider.darkTheme
                          ? Colors.white
                          : Colors
                              .black, //DARK THEME HERE------------------------------
                      fontWeight: FontWeight.bold,
                      fontFamily: "mulish"),
                ),
              )
            ],
          ),
          elevation: 0.0,
        ),
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
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Color(0xfff5f8fd),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          margin: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: searchEditingController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search Wallpaper",
                                  ),
                                  onSubmitted: _handleSubmitted,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Search(
                                                searchQuery:
                                                    searchEditingController
                                                        .text,
                                              )));
                                },
                                child: Container(child: Icon(Icons.search)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        wallpaperList(wallpaper: wallpaper, context: context)
                      ],
                    ),
                  )),
      ),
    );
  }
}
