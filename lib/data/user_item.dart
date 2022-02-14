import 'dart:convert';

import 'package:oman_001/utils/utils.dart';

import 'message_item.dart';
import 'search_item.dart';
import 'cart_item.dart';
import 'order_item.dart';
import 'review_item.dart';
import 'address_item.dart';
import 'trans_item.dart';
import 'block_item.dart';
import 'billing_item.dart';
import 'comment_item.dart';
import 'store_item.dart';
import 'follow_item.dart';
import 'history_item.dart';
import 'goods_item.dart';
import 'list_item.dart';

class UserItem {
  //--------------------------------------------------------------
  //
  //  user data..
  //

  String? id;
  int   ? status;
  String? nickName;

  String? pic;
  String? picBack;
  String? message;    // 소개

  int   ? likes;
  int   ? comments;
  int   ? following;
  int   ? follower;

  Map<String, HistoryItem>?     historyData;    // 히스토리 목록..
  Map<String, StoreItem>?       storeData;      // 샵정보 목록..  user > store > goods
  Map<String, GoodsItem>?       goodsData;      // 상품 목록..

  Map<String, FollowItem>?      followingData;  // 팔로잉 목록..
  Map<String, FollowItem>?      followerData;   // 팔로워 목록..

  Map<String, CommentItem>?     commentData;    // 코맨트 목록..
  Map<String, SearchItem>?      searchData;     // 검색 목록..
  Map<String, MessageItem>?     messageData;    // 대화 목록..

  List<String>?    categoryData;    // 관심 주제 목록..
  List<String>?    jobData;         // 직업 카테고리 목록..

  DateTime? updateTime;
  DateTime? createTime;

  //--------------------------------------------------------------
  //
  //  my user only..
  //

  String? password;
  String? loginType;
  String? loginId;

  String? name;
  String? nameEx;
  String? birth;
  String? email;
  String? phone;
  int   ? gender;

  String? pushId;
  String? token;      // connection check token..

  Map<String, String>?          optionData;     // 옵션 목록.. pushOn, autoPlay,
  Map<String, ReviewItem>?      reviewData;     // 리뷰 목록..

  Map<String, BlockItem>?       blockData;      // 차단/신고 목록..
  Map<String, BillingItem>?     billingData;    // 결제수단 목록..
  Map<String, TransItem>?       transData;      // 배송정보 목록..
  Map<String, AddressItem>?     shipAddrData;   // 배송주소 목록..
  Map<String, CartItem>?        cartData;       // 쇼핑카트 목록..
  Map<String, OrderItem>?       orderData;      // 주문 목록..

  Map<String, ListItem>?        socialData;     // 소셜 목록..
  Map<String, ListItem>?        couponData;     // 쿠폰 목록..
  Map<String, ListItem>?        viewData;       // 최근 본 상품 / 재능 목록..

  DateTime? loginTime;
  DateTime? logoutTime;
  DateTime? deleteTime;


  UserItem(
      this.id,
      this.status,
      this.nickName,
      {
        this.pic,
        this.picBack,
        this.message,

        this.likes,
        this.comments,
        this.following,
        this.follower,

        this.historyData,
        this.storeData,
        this.goodsData,

        this.followingData,
        this.followerData,

        this.commentData,
        this.searchData,
        this.messageData,

        this.categoryData,
        this.jobData,

        this.updateTime,
        this.createTime,

        //---------------------------------------------------

        this.password,
        this.loginType,
        this.loginId,

        this.name,
        this.nameEx,
        this.birth,
        this.email,
        this.phone,
        this.gender,

        this.pushId,
        this.token,

        this.optionData,
        this.reviewData,

        this.blockData,
        this.billingData,
        this.transData,
        this.shipAddrData,
        this.cartData,
        this.orderData,

        this.socialData,
        this.couponData,
        this.viewData,

        this.loginTime,
        this.logoutTime,
        this.deleteTime,
      });

  UserItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = STR(json['id'         ]);
      status      = INT(json['status'     ], defaultValue: 1);
      nickName    = STR(json['nickName'   ]);

      pic         = STR(json['pic'        ]);
      picBack     = STR(json['picBack'    ]);
      message     = STR(json['message'    ]);

      likes       = INT(json['likes'      ]);
      comments    = INT(json['comments'   ]);
      following   = INT(json['following'  ]);
      follower    = INT(json['follower'   ]);

      historyData = {};
      json['historyData']!.forEach((key, item) {
        historyData![key.toString()] ??= HistoryItem.fromJson(item);
      });

      // storeData = {};
      // json['storeData']!.forEach((key, item) {
      //   storeData![key.toString()] ??= StoreItem.fromJson(item);
      // });
      //
      // goodsData = {};
      // json['goodsData']!.forEach((key, item) {
      //   goodsData![key.toString()] ??= GoodsItem.fromJson(item);
      // });
      //
      // followingData = {};
      // json['followingData']!.forEach((key, item) {
      //   followingData![key.toString()] ??= FollowItem.fromJson(item);
      // });
      //
      // followerData = {};
      // json['followerData']!.forEach((key, item) {
      //   followerData![key.toString()] ??= FollowItem.fromJson(item);
      // });
      //
      // commentData = {};
      // json['commentData']!.forEach((key, item) {
      //   commentData![key.toString()] ??= CommentItem.fromJson(item);
      // });
      //
      // searchData = {};
      // json['searchData']!.forEach((key, item) {
      //   searchData![key.toString()] ??= SearchItem.fromJson(item);
      // });
      //
      // messageData = {};
      // json['messageData']!.forEach((key, item) {
      //   messageData![key.toString()] ??= MessageItem.fromJson(item);
      // });

      // categoryData = [];
      // for (var item in json['categoryData']!) {
      //   categoryData!.add(item.toString());
      // }
      //
      // jobData = [];
      // for (var item in json['jobData']!) {
      //   jobData!.add(item.toString());
      // }
      //
      // updateTime = DateTime.parse(json['updateTime']!.toString());
      // createTime = DateTime.parse(json['createTime']!.toString());

      //-----------------------------------------------------------------

      password    = STR(json['password'   ]);
      loginType   = STR(json['loginType'  ]);
      loginId     = STR(json['loginId'    ]);

      name        = STR(json['name'       ]);
      nameEx      = STR(json['nameEx'     ]);
      birth       = STR(json['birth'      ]);
      email       = STR(json['email'      ]);
      phone       = STR(json['phone'      ]);
      gender      = INT(json['gender'     ]);

      pushId      = STR(json['pushId'     ]);
      token       = STR(json['token'      ]);

      // optionData = {};
      // for (var item in json['optionData']!) {
      //   var itemId = item['id'].toString();
      //   optionData![itemId] ??= item['value']!;
      // }
      //
      // reviewData = {};
      // for (var item in json['reviewData']!) {
      //   var itemId = item['id'].toString();
      //   reviewData![itemId] ??= ReviewItem.fromJson(item);
      // }
      //
      // blockData = {};
      // for (var item in json['blockData']!) {
      //   var itemId = item['id'].toString();
      //   blockData![itemId] ??= BlockItem.fromJson(item);
      // }
      //
      // billingData = {};
      // for (var item in json['billingData']!) {
      //   var itemId = item['id'].toString();
      //   billingData![itemId] ??= BillingItem.fromJson(item);
      // }
      //
      // transData = {};
      // for (var item in json['transData']!) {
      //   var itemId = item['id'].toString();
      //   transData![itemId] ??= TransItem.fromJson(item);
      // }
      //
      // shipAddrData = {};
      // for (var item in json['shipAddrData']!) {
      //   var itemId = item['id'].toString();
      //   shipAddrData![itemId] ??= AddressItem.fromJson(item);
      // }
      //
      // cartData = {};
      // for (var item in json['cartData']!) {
      //   var itemId = item['id'].toString();
      //   cartData![itemId] ??= CartItem.fromJson(item);
      // }
      //
      // orderData = {};
      // for (var item in json['orderData']!) {
      //   var itemId = item['id'].toString();
      //   orderData![itemId] ??= OrderItem.fromJson(item);
      // }
      //
      // socialData = {};
      // for (var item in json['socialData']!) {
      //   var itemId = item['id'].toString();
      //   socialData![itemId] ??= ListItem.fromJson(item);
      // }
      //
      // couponData = {};
      // for (var item in json['couponData']!) {
      //   var itemId = item['id'].toString();
      //   couponData![itemId] ??= ListItem.fromJson(item);
      // }
      //
      // goodsShowData = {};
      // for (var item in json['goodsShowData']!) {
      //   var itemId = item['id'].toString();
      //   goodsShowData![itemId] ??= ListItem.fromJson(item);
      // }
      //
      // loginTime     = DateTime.parse(json['loginTime' ]!.toString());
      // logoutTime    = DateTime.parse(json['logoutTime']!.toString());
      // deleteTime    = DateTime.parse(json['deleteTime']!.toString());
    } catch(e) {
      print("--> UserItem error : $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'           ] ??= id;
    data['status'       ] ??= status;
    data['nickname'     ] ??= nickName;

    data['pic'          ] ??= pic;
    data['picBack'      ] ??= picBack;
    data['message'      ] ??= message;

    data['likes'        ] ??= likes;
    data['comments'     ] ??= comments;

    data['historyData'  ] ??= historyData;
    data['storeData'    ] ??= storeData;
    data['goodsData'    ] ??= goodsData;
    data['followingData'] ??= followingData;
    data['followerData' ] ??= followerData;

    data['commentData'  ] ??= commentData;
    data['searchData'   ] ??= searchData;

    data['categoryData' ] ??= categoryData;
    data['jobData'      ] ??= jobData;

    data['updateTime'   ] ??= updateTime;
    data['createTime'   ] ??= createTime;

    //---------------------------------------------------------------

    data['password'     ] ??= password;
    data['loginId'      ] ??= loginId;
    data['loginType'    ] ??= loginType;

    data['name'         ] ??= name;
    data['nameEx'       ] ??= nameEx;
    data['birth'        ] ??= birth;
    data['email'        ] ??= email;
    data['phone'        ] ??= phone;
    data['gender'       ] ??= gender;

    data['pushId'       ] ??= pushId;
    data['token'        ] ??= token;

    data['optionData'   ] ??= optionData;
    data['reviewData'   ] ??= reviewData;

    data['blockData'    ] ??= blockData;
    data['billingData'  ] ??= billingData;
    data['transData'    ] ??= transData;
    data['shipAddrData' ] ??= shipAddrData;
    data['cartData'     ] ??= cartData;
    data['orderData'    ] ??= orderData;

    data['socialData'   ] ??= socialData;
    data['couponData'   ] ??= couponData;
    data['viewData'     ] ??= viewData;

    data['loginTime'    ] ??= loginTime;
    data['logoutTime'   ] ??= logoutTime;
    data['deleteTime'   ] ??= deleteTime;

    return data;
  }
}
