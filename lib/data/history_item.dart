import 'package:oman_001/data/goods_item.dart';
import 'package:oman_001/utils/utils.dart';

import 'bid_item.dart';
import 'comment_item.dart';
import 'address_item.dart';

class HistoryItem {
  String? id;
  int?    status;
  String? title;
  String? desc;
  String? url;
  String? creatorId;  // origin creator id
  String? ownerId;    // current owner id
  double? price;      // last price
  int   ? likes;
  int   ? type;       // 0: photo, 1: video, 2: music

  Map<String, CommentItem>?       commentData;
  Map<String, BidItem>?           bidData;      // bid data..
  Map<String, AddressItem>?       placeData;    // place data..  위치표시.
  Map<String, HistoryGoodsItem>?  hisGoodsItem; // history goods data.. 상품표시.

  Map<String, String>?            optionData;   // option data.. // bid, comment, like...
  List<String>?                   tagData;   // tag list...

  DateTime? updateTime;
  DateTime? createTime;

  HistoryItem(
      this.id,
      this.title,
      {
        this.status,
        this.desc,
        this.url,
        this.creatorId,
        this.ownerId,
        this.likes,
        this.type,

        this.commentData,
        this.bidData,
        this.placeData,
        this.hisGoodsItem,
        this.optionData,
        this.tagData,

        this.updateTime,
        this.createTime,
      });

  HistoryItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id        = STR(json['id'     ]);
      status    = INT(json['status' ], defaultValue: 1);
      title     = STR(json['title'  ]);
      desc      = STR(json['desc'   ]);
      url       = STR(json['url'    ]);
      likes     = INT(json['likes'  ]);
      type      = INT(json['type'   ]);

      // commentData = {};
      // for (var item in json['commentData']!) {
      //   var itemId = item['id'].toString();
      //   commentData![itemId] ??= CommentItem.fromJson(item);
      // }
      //
      // bidData = {};
      // for (var item in json['bidData']!) {
      //   var itemId = item['id'].toString();
      //   bidData![itemId] ??= BidItem.fromJson(item);
      // }
      //
      // placeData = {};
      // for (var item in json['placeData']!) {
      //   var itemId = item['id'].toString();
      //   placeData![itemId] ??= AddressItem.fromJson(item);
      // }
      //
      // hisGoodsItem = {};
      // for (var item in json['hisGoodsItem']!) {
      //   var itemId = item['id'].toString();
      //   hisGoodsItem![itemId] ??= HistoryGoodsItem.fromJson(item);
      // }
      //
      // optionData = {};
      // for (var item in json['optionData']!) {
      //   var itemId = item['id'].toString();
      //   optionData![itemId] ??= item['value']!;
      // }
      //
      // tagData = [];
      // for (var item in json['tagData']!) {
      //   tagData!.add(item);
      // }
      //
      // updateTime  = DateTime.parse(json['updateTime']!.toString());
      // createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> HistoryItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'         ] ??= id;
    data['status'     ] ??= status;
    data['title'      ] ??= title;
    data['desc'       ] ??= desc;
    data['url'        ] ??= url;
    data['likes'      ] ??= likes;
    data['type'       ] ??= type;

    data['commentData'  ] ??= commentData;
    data['bidData'      ] ??= bidData;
    data['placeData'    ] ??= placeData;
    data['hisGoodsItem' ] ??= hisGoodsItem;
    data['optionData'   ] ??= optionData;
    data['tagData'      ] ??= tagData;

    data['updateTime' ] ??= updateTime;
    data['createTime' ] ??= createTime;

    return data;
  }
}

class HistoryGoodsItem {
  String? id;
  int?    status;
  String? targetType;
  String? targetId;
  String? title;
  double? startTime;
  double? endTime;
  double? showPosX;
  double? showPosY;
  double? showSizeX;
  double? showSizeY;

  //----------------------------------

  GoodsItem? goodsItem;

  HistoryGoodsItem(
      this.id,
      {
        this.status,
        this.targetType,
        this.targetId,
        this.title,
        this.startTime,
        this.endTime,
        this.showPosX,
        this.showPosY,
        this.showSizeX,
        this.showSizeY,
      });

  HistoryGoodsItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'   ]!;
      status      = int.parse(json['status']!.toString());
      targetType  = json['targetType' ]!;
      targetId    = json['targetId'   ]!;
      title       = json['title'      ]!;
      startTime   = double.parse(json['startTime' ]!.toString());
      endTime     = double.parse(json['endTime'   ]!.toString());
      showPosX    = double.parse(json['showPosX'  ]!.toString());
      showPosY    = double.parse(json['showPosY'  ]!.toString());
      showSizeX   = double.parse(json['showSizeX' ]!.toString());
      showSizeY   = double.parse(json['showSizeY' ]!.toString());
    } catch (e) {
      print("--> HistoryGoodsItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'         ] ??= id;
    data['status'     ] ??= status;
    data['targetType' ] ??= targetType;
    data['targetId'   ] ??= targetId;
    data['title'      ] ??= title;
    data['showTime'   ] ??= startTime;
    data['endTime'    ] ??= endTime;
    data['showPosX'   ] ??= showPosX;
    data['showPosY'   ] ??= showPosY;
    data['showSizeX'  ] ??= showSizeX;
    data['showSizeY'  ] ??= showSizeY;

    return data;
  }
}
