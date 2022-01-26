import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:oman_001/data/goods_item.dart';
import 'package:oman_001/data/history_item.dart';

import 'demo_data.dart';
import 'home_item.dart';

class MainListAPI {
  List<HomeItem>? listData;

  load() async {
    listData = await getAsyncLocalHomeList();
  }

  Future<List<HomeItem>> getAsyncLocalHomeList() async {
    List<HomeItem> listItem = [];
    for (var element in demoData["home_data"]!) {
      listItem.add(HomeItem.fromJson(element));
      print("--> getLocalHomeList : ${listItem[listItem.length-1].user?.name}");
    }
    return listItem;
  }

  List<HomeItem> getLocalHomeList() {
    List<HomeItem> listItem = [];
    for (var element in demoData["home_data"]!) {
      listItem.add(HomeItem.fromJson(element));
      print("--> getLocalHomeList : ${listItem[listItem.length-1].user?.name}");
    }
    return listItem;
  }

// Future<List<HomeItem>> getHomeList() async {
  //   List<HomeItem> listItem = [];
  //   var data = await FirebaseFirestore.instance.collection("Videos").get();
  //   for (var element in data.docs) {
  //     listItem.add(HomeItem.fromJson(element.data()));
  //   }
  //   return listItem;
  // }
  //
  // // to firebase burkit..
  // Future<void> addDemoData() async {
  //   for (var video in demoData["home_data"]!) {
  //     await FirebaseFirestore.instance.collection("Videos").add(video);
  //   }
  // }
}

class StoreListAPI {
  List<GoodsItem>? listData;

  load() async {
    listData = await getAsyncLocalGoodsList();
  }

  Future<List<GoodsItem>> getAsyncLocalGoodsList() async {
    List<GoodsItem> listItem = [];
    print("--> getLocalGoodsList : ${demoData["goods_data"]}");
    for (var element in demoData["goods_data"]!) {
      listItem.add(GoodsItem.fromJson(element));
      print("--> getLocalGoodsList : ${listItem[listItem.length-1].imageUrl}");
    }
    return listItem;
  }

  List<GoodsItem> getLocalGoodsList() {
    List<GoodsItem> listItem = [];
    print("--> getLocalGoodsList : ${demoData["goods_data"]}");
    for (var element in demoData["goods_data"]!) {
      listItem.add(GoodsItem.fromJson(element));
      print("--> getLocalGoodsList : ${listItem[listItem.length-1].imageUrl}");
    }
    return listItem;
  }
}
