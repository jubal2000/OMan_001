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
    for (var element in homeDataDemo) {
      HomeItem item = HomeItem.fromJson(element);
      print("--> element : $item");
      listData!.add(item);
    }
    return listData!;
  }

  Future<List<HomeItem>> getHomeList() async {
    var data = await FirebaseFirestore.instance.collection("Videos").get();
    for (var element in data.docs) {
      HomeItem item = HomeItem.fromJson(element.data());
      listData!.add(item);
    }
    return listData!;
  }

  // to firebase burkit..
  Future<void> addDemoData() async {
    for (var video in homeDataDemo) {
      await FirebaseFirestore.instance.collection("Videos").add(video);
    }
  }
}
