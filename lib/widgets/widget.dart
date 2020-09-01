import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splash/constant.dart';
import 'package:splash/size_config.dart';

Widget AppName() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Hero(
          tag: "appTitle",
          child: Text(
            "Splash",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(25),
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Icon(
          Icons.search,
          color: CupertinoColors.black,
        ),
      ],
    ),
  );
}
