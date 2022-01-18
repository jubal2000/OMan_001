import 'dart:ui';

import 'package:flutter/cupertino.dart';

class GoodsItem {
  String id;
  String title;
  String desc;
  String ribbon;
  String imageUrl;

  String category1;
  String category2;

  double price;
  double priceOrg;
  double saleRatio;
  double distance;
  int trades;
  int comments;
  int likes;

  List<String> commentData  = []; // TODO
  List<String> imageData    = []; // TODO

  GoodsItem(
      {
        required this.id,
        required this.title,
        required this.desc,
        required this.ribbon,
        required this.imageUrl,

        required this.category1,
        required this.category2,

        required this.price,
        required this.priceOrg,
        required this.saleRatio,
        required this.distance,

        required this.trades,
        required this.comments,
        required this.likes,

        required this.commentData,
        required this.imageData,
      });

  GoodsItem.fromJson(Map<dynamic, dynamic> json)
      : id          = json['id'],
        title       = json['title'],
        desc        = json['desc'],
        ribbon      = json['ribbon'],
        imageUrl    = json['imageUrl'],
        category1   = json['category1'],
        category2   = json['category2'],
        price       = json['price'],
        priceOrg    = json['priceOrg'],
        saleRatio   = json['saleRatio'],
        distance    = json['distance'],
        trades      = json['trades'],
        comments    = json['comments'],
        likes       = json['likes'];
        // commentData = json['commentData'],
        // imageData   = json['imageData'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id']          = id;
    data['title']       = title;
    data['desc']        = desc;
    data['ribbon']      = ribbon;
    data['imageUrl']    = imageUrl;
    data['category1']   = category1;
    data['category2']   = category2;
    data['price']       = price;
    data['priceOrg']    = priceOrg;
    data['saleRatio']   = saleRatio;
    data['trades']      = trades;
    data['comments']    = comments;
    data['likes']       = likes;
    // data['commentData'] = commentData;
    // data['imageData']   = imageData;
    return data;
  }
}
