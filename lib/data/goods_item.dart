import 'package:video_player/video_player.dart';

class GoodsItem {
  String id;
  String title;
  String desc;
  double sale;
  double price;
  double priceOrg;
  int    like;
  String category;
  List<String> commentData  = []; // TODO
  List<String> imageData    = []; // TODO

  VideoPlayerController? controller;

  GoodsItem(
      { required this.id,
        required this.title,
        required this.desc,
        required this.sale,
        required this.price,
        required this.priceOrg,
        required this.like,
        required this.category,
        required this.commentData,
        required this.imageData,
      });

  GoodsItem.fromJson(Map<dynamic, dynamic> json)
      : id          = json['id'],
        title       = json['title'],
        desc        = json['desc'],
        sale        = json['sale'],
        price       = json['price'],
        priceOrg    = json['priceOrg'],
        like        = json['like'],
        category    = json['category'],
        commentData = json['comments'],
        imageData   = json['images'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id']        = id;
    data['title']     = title;
    data['desc']      = desc;
    data['sale']      = sale;
    data['price']     = price;
    data['priceOrg']  = priceOrg;
    data['like']      = like;
    data['comments']  = commentData;
    data['category']  = category;
    data['images']    = imageData;
    return data;
  }
}
