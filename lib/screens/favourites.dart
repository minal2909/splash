import 'package:flutter/material.dart';
import 'package:splash/model/wallpaper_model.dart';
import 'package:splash/widgets/widget.dart';
import 'package:provider/provider.dart';

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
    _favourites = [];
  }

  @override
  Widget build(BuildContext context) {
    //var myDatabase = Provider.of<MyDatabase>(context);

    return Scaffold(
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
