
import 'package:flutter/material.dart';
import 'package:oman_001/screens/goods_item_card.dart';

class MainMenuID {
  static int get home   => 0;
  static int get search => 1;
  static int get oman   => 2;
  static int get store  => 3;
  static int get my     => 4;
}

class StoreMode {
  static int get talent => 0;
  static int get goods  => 1;
}

class AppData {
  static final AppData _singleton = AppData._internal();

  final int SCROLL_SPEED = 250;
  static var isMainDataReady = false;
  static var isStoreDataReady = false;
  static var isShowPlayerInfo = true;
  static var isMainPlay = true;
  static var isAutoPlay = false;

  static var mainMenuIndex = MainMenuID.home;
  static var storeMode = StoreMode.talent;

  static var MainTheme = ThemeData(
    canvasColor: Colors.white,
    backgroundColor: Colors.black,
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.black),
    fontFamily: 'NotoSans',
    textTheme: TextTheme(
      headline1: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
      headline2: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black),
      subtitle1: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w800, color: Colors.black),
      subtitle2: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),
      bodyText1: const TextStyle(fontSize: 11.0, fontWeight: FontWeight.normal, color: Colors.black),
      bodyText2: const TextStyle(fontSize: 11.0, fontWeight: FontWeight.normal, color: Colors.grey),
    ),
  );

  static List<GoodsItemCard> goodsList = [];

  factory AppData() {
    return _singleton;
  }

  AppData._internal();
}
