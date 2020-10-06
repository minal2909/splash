import 'package:flutter/material.dart';
import 'package:splash/constant.dart';
import 'package:splash/size_config.dart';
import 'package:splash/widgets/Mydemo.dart';

import 'splash_content.dart';
import 'default_button.dart';
import 'package:splash/screens/home.dart';
import 'package:splash/routs.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {"text": "Hey!Welcome to Splash", "image": "images/splash_first.png"},
    {
      "text":
          "You can directly Set the wallpaper from the app in home,lock and Home & Lock Screen",
      "image": "images/splash_setWallpaper.png"
    },
    {"text": "Easy share and download", "image": "images/splash_share.png"},
    {"text": "set to favourites", "image": "images/splash_fav.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                    text: splashData[index]["text"],
                    image: splashData[index]["image"]),
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: [
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                      Spacer(
                        flex: 3,
                      ),
                      defaultButton(
                        text: "Continue",
                        press: () {
                          Navigator.pushNamed(context, MyDemo.routeName);
                        },
                      ),
                      Spacer(),
                    ],
                  ),
                ))
          ],
        ),
      ),
    ));
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5.0),
      height: 6.0,
      width: currentPage == index ? 20.0 : 6.0,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFd8d8d8),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}
