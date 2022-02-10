import 'dart:ui';

import 'package:flutter/cupertino.dart';

class GoodsItem {
  String? id;
  int   ? status;
  String? userId;
  String? shopId;

  String? title;
  String? desc;
  String? ribbon;
  String? imageUrl;

  String? category1;
  String? category2;

  double? price;
  double? priceOrg;
  double? saleRatio;
  double? distance;

  List<String>? commentData; // TODO
  List<String>? imageData; // TODO
  List<String>? optionData; // TODO

  DateTime? updateTime;
  DateTime? createTime;

  //-----------------------------------------------

  int trades = 0;
  int comments = 0;
  int likes = 0;

  String optionStr = "option: texttexttexttexttexttexttext..";

  GoodsItem(
      this.id,
      this.status,
      this.userId,
      this.shopId,
      {
        this.title,
        this.desc,
        this.ribbon,
        this.imageUrl,

        this.category1,
        this.category2,

        this.price,
        this.priceOrg,
        this.saleRatio,
        this.distance,

        this.commentData,
        this.imageData,
        this.optionData,

        this.trades = 0,
        this.comments = 0,
        this.likes = 0,

        this.updateTime,
        this.createTime,
      });

  GoodsItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'       ]!;
      status      = int.parse(json['status']!.toString());
      userId      = json['userId'   ]!;
      shopId      = json['shopId'   ]!;

      title       = json['title'    ]!;
      desc        = json['desc'     ]!;
      ribbon      = json['ribbon'   ]!;
      imageUrl    = json['imageUrl' ]!;

      category1   = json['category1']!;
      category2   = json['category2']!;

      price       = json['price'    ]!;
      priceOrg    = json['priceOrg' ]!;
      saleRatio   = json['saleRatio']!;
      distance    = json['distance' ]!;

      commentData  = json['commentData' ]!;
      imageData    = json['imageData'   ]!;
      optionData   = json['optionData'  ]!;

      trades      = json['trades'   ]!;
      comments    = json['comments' ]!;
      likes       = json['likes'    ]!;

      updateTime  = DateTime.parse(json['updateTime']!.toString());
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> GoodsItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'         ] ??= id;
    data['status'     ] ??= status;
    data['userId'     ] ??= userId;
    data['shopId'     ] ??= shopId;

    data['title'      ] ??= title;
    data['desc'       ] ??= desc;
    data['ribbon'     ] ??= ribbon;
    data['imageUrl'   ] ??= imageUrl;

    data['category1'  ] ??= category1;
    data['category2'  ] ??= category2;

    data['price'      ] ??= price;
    data['priceOrg'   ] ??= priceOrg;
    data['saleRatio'  ] ??= saleRatio;
    data['distance'   ] ??= distance;

    data['commentData'] ??= commentData;
    data['imageData'  ] ??= imageData;
    data['optionData' ] ??= optionData;

    data['trades'     ] ??= trades;
    data['comments'   ] ??= comments;
    data['likes'      ] ??= likes;
    // data['commentData'] = commentData;
    // data['imageData']   = imageData;

    data['updateTime' ] ??= updateTime;
    data['createTime' ] ??= createTime;
    return data;
  }
}
