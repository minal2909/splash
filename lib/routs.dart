import 'package:flutter/widgets.dart';
import 'screens/splash_screen.dart';
import 'screens/home.dart';
import 'screens/search.dart';
import 'screens/image_view.dart';
import 'widgets/tabBar.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  Home.routeName: (context) => Home(),
  Search.routeName: (context) => Search(),
  ImageView.routeName: (context) => ImageView(),
  TabBarSplash.routeName: (context) => TabBarSplash(),
};
