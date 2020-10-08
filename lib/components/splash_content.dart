import 'package:flutter/material.dart';
import 'package:splash/constant.dart';
import 'package:splash/size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    this.text,
    this.image,
    Key key,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Hero(
          tag: "appTitle",
          transitionOnUserGestures: true,
          child: Material(
            type: MaterialType.transparency,
            child: Text(
              "Incredible 4K wallpapers 2020",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(25),
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: "mulish"),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265),
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
      ],
    );
  }
}
