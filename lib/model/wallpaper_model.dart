class WallpaperModel {
  String photographer;
  String photographerURL;
  int photographerID;
  bool liked;
  SrcModel src;

  WallpaperModel({
    this.photographerURL,
    this.photographerID,
    this.photographer,
    this.liked,
    this.src,
  });

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
        photographerURL: jsonData["photographer_url"],
        photographerID: jsonData["photographer_id"],
        photographer: jsonData["photographer"],
        liked: jsonData["liked"],
        src: SrcModel.fromMap(jsonData["src"]));
  }
}

class SrcModel {
  String portrait;
  String large;
  String landscape;
  String medium;

  SrcModel({this.portrait, this.landscape, this.large, this.medium});

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
        portrait: srcJson["portrait"],
        large: srcJson["large"],
        landscape: srcJson["landscape"],
        medium: srcJson["medium"]);
  }
}
