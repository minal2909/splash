import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splash/data/data.dart';
import 'package:splash/model/categories_model.dart';
import 'package:splash/model/wallpaper_model.dart';
import 'package:splash/screens/favourites.dart';
import 'package:splash/screens/home.dart';
import 'package:splash/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:splash/screens/search.dart';
import 'package:splash/screens/categories.dart';
import 'package:splash/screens/image_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyDemo extends StatelessWidget {
  static String routeName = "/myDemo";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter demo",
      home: TabBarSplash(),
    );
  }
}

class TabBarSplash extends StatefulWidget {
  //static String routeName = "/tabBar";
  @override
  _TabBarSplashState createState() => _TabBarSplashState();
}

class _TabBarSplashState extends State<TabBarSplash>
    with SingleTickerProviderStateMixin {
  List<CategoriesModel> categories = new List();
  TextEditingController searchEditingController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  TabController _controller;

  @override
  void initState() {
    categories = getCategories();
    super.initState();
    _controller = new TabController(length: 2, vsync: this);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 48.0,
        color: Colors.white,
        child: Column(
          children: [
            AppName(),
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
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Search(
                                    searchQuery: searchEditingController.text,
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
            Container(
              height: 80,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoriesTile(
                      title: categories[index].catagoriesName,
                      imgURL: categories[index].imgURL,
                    );
                  }),
            ),
            Expanded(
              flex: 1,
              child: Scaffold(
                body: Column(
                  children: [
                    Container(
                      child: TabBar(
                        controller: _controller,
                        labelColor: Colors.black,
                        tabs: [
                          Tab(
                            icon: const Icon(
                              Icons.trending_up,
                              color: Colors.black,
                            ),
                            text: "Trending",
                          ),
                          Tab(
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.black,
                            ),
                            text: "Favourite",
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Color(0xFF263238),
                        height: 80,
                        child: TabBarView(
                          controller: _controller,
                          children: [
                            Card(
                              child: Home(),
                            ),
                            Card(
                              child: Favourites(),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgURL;
  final String title;

  CategoriesTile({@required this.imgURL, @required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Categories(categoryName: title.toLowerCase());
        }));
      },
      child: Container(
        margin: EdgeInsets.only(right: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgURL,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                //color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    //fontFamily: "mulish",
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
