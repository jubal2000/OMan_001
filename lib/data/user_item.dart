import 'dart:convert';

import 'history_item.dart';
import 'goods_item.dart';

class UserItem {
  String? id;
  String? userId;
  String? name;
  String? pic;
  String? picBack;
  String? gender;
  String? desc;
  String? pushId;
  String? token;   // connection check token..
  int   ? likes;

  List<HistoryItem>  historyData  = [];
  List<GoodsItem>    storeData    = [];
  List<String>?      optionData; // TODO
  List<String>?      followingData; // TODO
  List<String>?      followerData; // TODO
  List<String>?      commentData; // TODO

  UserItem(
      { required this.id,
        required this.userId,
        required this.name,
        required this.pic,
        required this.picBack,
        required this.gender,
        required this.desc,
        required this.pushId,
        required this.token,
        required this.likes,
        required this.commentData,

        required this.historyData,
        required this.storeData,
        required this.optionData,
        required this.followingData,
        required this.followerData,
      });

  UserItem.fromJson(Map<dynamic, dynamic> json) {
    id        = json['id']!;
    userId    = json['userId']!;
    name      = json['name']!;
    pic       = json['pic']!;
    picBack   = json['picBack']!;
    gender    = json['gender']!;
    desc      = json['desc']!;
    pushId    = json['pushId']!;
    token     = json['token']!;
    likes     = int.parse(json['likes'].toString());

    historyData   = [];
    storeData     = [];
    optionData    = [];
    followingData = [];
    followerData  = [];
    commentData   = [];

    for (var item in json['history']!) {
      historyData.add(HistoryItem.fromJson(item));
    }

    for (var item in json['store']!) {
      storeData.add(GoodsItem.fromJson(item));
    }

    // optionData = json['option'],
    // followingData = json['following'],
    // followerData = json['follower'],
    // commentData = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id']            = id;
    data['userId']        = userId;
    data['name']          = name;
    data['pic']           = pic;
    data['picBack']       = picBack;
    data['gender']        = gender;
    data['desc']          = desc;
    data['pushId']        = pushId;
    data['token']         = token;
    data['likes']         = likes;

    data['history']       = historyData;
    data['store']         = storeData;
    data['option']        = optionData;
    data['following']     = followingData;
    data['follower']      = followerData;
    data['comments']      = commentData;
    return data;
  }
}
