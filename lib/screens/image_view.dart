import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:splash/model/wallpaper_model.dart';
import 'package:splash/widgets/widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaperplugin/wallpaperplugin.dart';
import 'package:path_provider/path_provider.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'package:splash/data/data.dart';

class ImageView extends StatefulWidget {
  static String routeName = "/imageView";

  final String imgURL;
  ImageView({
    @required this.imgURL,
  });

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;
  String _localpath;
  List<dynamic> data;

  bool liked = false;

  Future<String> getimages() async {
    var getdata = await http.get(
        "https://api.pexels.com/v1/curated?per_page=15&page=1",
        headers: {"Authorization": apiKey});
    setState(() {
      var jsondata = json.decode(getdata.body);
      data = jsondata['results'];
    });
    return "Success";
  }

  _pressed() {
    setState(() {
      liked = !liked;
    });
  }

  _onTapProcess(context, values) {
    return AlertDialog(
      title: Text("Set as Wallpaper"),
      actions: [
        FlatButton(
          onPressed: () async {
            print(context);
            if (_askPermission() != null) {
              Dio dio = Dio();
              final Directory appdirectory =
                  await getExternalStorageDirectory();
              final Directory directory =
                  await Directory(appdirectory.path + '/wallpapers')
                      .create(recursive: true);
              final String dir = directory.path;
              String localpath = '$dir/myimages.jpeg';

              try {
                dio.download(values, localpath);
                setState(() {
                  _localpath = localpath;
                });
                //print(context);
                Wallpaperplugin.setAutoWallpaper(localFile: _localpath);
              } on PlatformException catch (e) {
                print(e);
              }

              Navigator.pop(context);
            } else {}
          },
          child: Text("YES"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("NO"),
        )
      ],
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: 'imgURL',
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: kIsWeb
                  ? Image.network(widget.imgURL, fit: BoxFit.cover)
                  : CachedNetworkImage(
                      imageUrl: widget.imgURL,
                      placeholder: (context, url) => Container(
                        color: Colors.black,
                        //Color(0xfff5f8fd),
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        if (kIsWeb) {
                          _launchURL(widget.imgURL);
                        } else {
                          _save();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff1c1b1b).withOpacity(0.6),
                        ),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black.withOpacity(0.6),
                            border: Border.all(
                              width: 1,
                              color: Colors.white60,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Color(0x36ffffff),
                                Color(0x0ffffff),
                              ],
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Icon(
                            Icons.file_download,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            // print(
                            context: context,
                            builder: (context) =>
                                _onTapProcess(context, widget.imgURL));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff1c1b1b).withOpacity(0.6),
                        ),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black.withOpacity(0.6),
                            border: Border.all(
                              width: 1,
                              color: Colors.white60,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Color(0x36ffffff),
                                Color(0x0ffffff),
                              ],
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Icon(
                            Icons.wallpaper,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xff1c1b1b).withOpacity(0.6),
                      ),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black.withOpacity(0.6),
                          border: Border.all(
                            width: 1,
                            color: Colors.white60,
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Color(0x36ffffff),
                              Color(0x0ffffff),
                            ],
                          ),
                        ),
                        // padding:
                        //     EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: IconButton(
                          onPressed: () {
                            _pressed();
                          },
                          alignment: Alignment.center,
                          icon: Icon(
                            liked ? Icons.favorite : Icons.favorite_border,
                            color: liked ? Colors.redAccent : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          )
        ],
      ),
    );
  }

  _save() async {
    if (Platform.isAndroid) {
      await _askPermission();
    }

    var response = await Dio()
        .get(widget.imgURL, options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  // _askPermission() async {
  //   if (Platform.isIOS) {
  //     //Map<PermissionGroup, PermissionStatus> permissions =
  //
  //     await PermissionHandler().requestPermissions([PermissionGroup.photos]);
  //   } else {
  //     //PermissionStatus permission =
  //     await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
  //   }
  // }

  static Future<bool> _askPermission() async {
    final PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission != PermissionStatus.granted) {
      final Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions(<PermissionGroup>[PermissionGroup.storage]);
      if (permissions[PermissionGroup.storage] != PermissionStatus.granted) {
        return null;
      }
    }
    return true;
  }
}
