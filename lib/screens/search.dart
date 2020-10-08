import 'dart:convert';

import 'package:flutter/material.dart';
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

  Widget row(WallpaperModel wallpaperModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          wallpaperModel.photographer,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          wallpaperModel.photographerURL,
        )
      ],
    );
  }

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
    getSearchWallpapers(widget.searchQuery);
    super.initState();
    searchEditingController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text(
                  "Search",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(25),
                      color: Color(0xff263238),
                      fontWeight: FontWeight.bold,
                      fontFamily: "mulish"),
                ),
              )
            ],
          ),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
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
                        // child: searchTextField =
                        //     AutoCompleteTextField<WallpaperModel>(
                        //   key: key,
                        //   clearOnSubmit: false,
                        //   suggestions: wallpaper,
                        //   decoration: InputDecoration(
                        //     border: InputBorder.none,
                        //     hintText: "Search Wallpaper",
                        //   ),
                        //   itemFilter: (item, query) {
                        //     return item.photographer
                        //         .toLowerCase()
                        //         .startsWith(query.toLowerCase());
                        //   },
                        //   itemSorter: (a, b) {
                        //     return a.photographer.compareTo(b.photographer);
                        //   },
                        //   itemSubmitted: (item) {
                        //     setState(() {
                        //       searchTextField.textField.controller.text =
                        //           item.photographer;
                        //     });
                        //   },
                        //   itemBuilder: (context, item) {
                        //     return row(item);
                        //   },
                        // ),
                        child: TextField(
                          controller: searchEditingController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Wallpaper",
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Search(
                                        searchQuery:
                                            searchEditingController.text,
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
                wallpaperList(wallpaper: wallpaper, context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
