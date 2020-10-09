import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class Utilities {
  static const String IMG_KEY = "IMAGE_KEY";
  static Future<bool> saveImage(String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(IMG_KEY, value);
  }

  static Future<String> getImage() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(IMG_KEY);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static Image imageFromBase64Sring(String base64String) {
    return Image.memory(base64Decode(base64String), fit: BoxFit.fill);
  }
}
