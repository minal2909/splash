class WallpaperModel {
  String photographer;
  String photographerURL;
  int photographerID;
  SrcModel src;

  WallpaperModel(
      {this.photographer, this.photographerID, this.photographerURL, this.src});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
      src: jsonData["src"],
      photographerURL: jsonData["photographer_url"],
      photographerID: jsonData["photographer_id"],
      photographer: jsonData["photographer"],
    );
  }
}

class SrcModel {
  String original;
  String small;
  String portrait;

  SrcModel({this.original, this.portrait, this.small});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
      original: jsonData["original"],
      small: jsonData["small"],
      portrait: jsonData["portrait"],
    );
  }
}
