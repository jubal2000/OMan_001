import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:oman_001/utils/utils.dart';

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
      id          = STR(json['id'       ]);
      status      = INT(json['status'   ]);
      userId      = STR(json['userId'   ]);
      shopId      = STR(json['shopId'   ]);

      title       = STR(json['title'    ]);
      desc        = STR(json['desc'     ]);
      ribbon      = STR(json['ribbon'   ]);
      imageUrl    = STR(json['imageUrl' ]);

      category1   = STR(json['category1']);
      category2   = STR(json['category2']);

      price       = DBL(json['price'    ]);
      priceOrg    = DBL(json['priceOrg' ]);
      saleRatio   = DBL(json['saleRatio']);
      distance    = DBL(json['distance' ]);

      trades      = INT(json['trades'   ]);
      comments    = INT(json['comments' ]);
      likes       = INT(json['likes'    ]);

      // commentData  = json['commentData' ]!;
      // imageData    = json['imageData'   ]!;
      // optionData   = json['optionData'  ]!;

      updateTime  = TME(json['updateTime']);
      createTime  = TME(json['createTime']);
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
