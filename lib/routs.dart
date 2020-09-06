import 'package:flutter/widgets.dart';
import 'screens/splash_screen.dart';
import 'screens/home.dart';
import 'screens/search.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  Home.routeName: (context) => Home(),
  Search.routeName: (context) => Search(),
};
