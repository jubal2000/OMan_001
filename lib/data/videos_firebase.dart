import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:oman_001/data/history_item.dart';

import 'demo_data.dart';
import 'home_item.dart';

class MainListAPI {
  List<HomeItem>? listData;

  load() async {
    listData = await getLocalHomeList();
  }

  Future<List<HomeItem>> getLocalHomeList() async {
    List<HomeItem> listItem = [];
    for (var element in homeDataDemo) {
      listItem.add(HomeItem.fromJson(element));
      print("--> getLocalHomeList : ${listItem[listItem.length-1].user?.name}");
    }
    return listItem;
  }

  Future<List<HomeItem>> getHomeList() async {
    List<HomeItem> listItem = [];
    var data = await FirebaseFirestore.instance.collection("Videos").get();
    for (var element in data.docs) {
      listItem.add(HomeItem.fromJson(element.data()));
    }
    return listItem;
  }

  // to firebase burkit..
  Future<void> addDemoData() async {
    for (var video in homeDataDemo) {
      await FirebaseFirestore.instance.collection("Videos").add(video);
    }
  }
}
