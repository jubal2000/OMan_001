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

  Map<String, HistoryItem>?  historyData;
  Map<String, GoodsItem>?    storeData;
  List<String>?      optionData; // TODO
  List<String>?      followingData; // TODO
  List<String>?      followerData; // TODO
  List<String>?      commentData; // TODO

  UserItem(
      this.id,
      this.userId,
      {
        this.name,
        this.pic,
        this.picBack,
        this.gender,
        this.desc,
        this.pushId,
        this.token,
        this.likes,
        this.commentData,

        this.historyData,
        this.storeData,
        this.optionData,
        this.followingData,
        this.followerData,
      });

  UserItem.fromJson(Map<dynamic, dynamic> json) {
    try {
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

      historyData   = {};
      storeData     = {};
      optionData    = [];
      followingData = [];
      followerData  = [];
      commentData   = [];

      for (var item in json['history']!) {
        var itemId = item['id'].toString();
        historyData![itemId] = HistoryItem.fromJson(item);
      }

      for (var item in json['store']!) {
        var itemId = item['id'].toString();
        storeData![itemId] = GoodsItem.fromJson(item);
      }
    } catch(e) {
      print("--> UserItem error : $e");
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
