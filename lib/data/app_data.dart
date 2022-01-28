
import 'package:flutter/material.dart';
import 'package:oman_001/screens/goods_item_card.dart';
import 'package:oman_001/utils/utils.dart';
import 'package:oman_001/widgets/search_widget.dart';

import 'goods_item.dart';
import 'home_item.dart';

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
  static var isAutoPlay = true; // start auto play..
  static var isSearchOn = false;

  static var mainMenuIndex = MainMenuID.home;
  static var storeMode = StoreMode.talent;

  static var myProfileTabViewHeight = 1200.0;
  static var searchWidgetKey = GlobalKey();
  static var mainScreenKey = GlobalKey<ScaffoldState>();

  static var MainTheme = ThemeData(
    canvasColor: Colors.white,
    backgroundColor: Colors.black,
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    unselectedWidgetColor: Colors.grey,
    toggleableActiveColor: Colors.purple,
    iconTheme: IconThemeData(color: Colors.black),
    fontFamily: 'NotoSansKR',
    textTheme: TextTheme(
      headline1: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
      headline2: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black),
      headline3: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.grey),
      headline4: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.white,
        shadows: outlinedText(strokeWidth: 1, strokeColor: Colors.black.withOpacity(0.1)),
      ),
      headline5: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.grey[200],
        shadows: outlinedText(strokeWidth: 1, strokeColor: Colors.black.withOpacity(0.1)),
      ),
      subtitle1: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black),
      subtitle2: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),
      bodyText1: const TextStyle(fontSize: 11.0, fontWeight: FontWeight.normal, color: Colors.black),
      bodyText2: const TextStyle(fontSize: 11.0, fontWeight: FontWeight.normal, color: Colors.grey),
    ),
  );

  static List<GoodsItemCard> goodsList = [];

  factory AppData() {
    return _singleton;
  }

  static setSearchEnable(status) {
    isSearchOn = status;
    if (searchWidgetKey.currentState != null) {
      var searchState = searchWidgetKey.currentState as SearchWidgetState;
      searchState.setHistoryListShow(isSearchOn);
    }
    if (!status) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  AppData._internal();

  static List<String> searchImageList = [
    'assets/sample/1.jpeg',
    'assets/sample/2.jpeg',
    'assets/sample/3.jpeg',
    'assets/sample/4.jpeg',
    'assets/sample/5.jpeg',
    'assets/sample/6.jpeg',
    'assets/sample/7.jpeg',
    'assets/sample/8.jpeg',
    'assets/sample/9.jpeg',
    'assets/sample/10.jpeg',
    'assets/sample/1.jpeg',
    'assets/sample/2.jpeg',
    'assets/sample/3.jpeg',
    'assets/sample/4.jpeg',
    'assets/sample/5.jpeg',
    'assets/sample/6.jpeg',
    'assets/sample/7.jpeg',
    'assets/sample/8.jpeg',
    'assets/sample/9.jpeg',
    'assets/sample/10.jpeg',
    'assets/sample/1.jpeg',
    'assets/sample/2.jpeg',
    'assets/sample/3.jpeg',
    'assets/sample/4.jpeg',
    'assets/sample/5.jpeg',
    'assets/sample/6.jpeg',
    'assets/sample/7.jpeg',
    'assets/sample/8.jpeg',
    'assets/sample/9.jpeg',
    'assets/sample/10.jpeg',
    'assets/sample/1.jpeg',
    'assets/sample/2.jpeg',
    'assets/sample/3.jpeg',
    'assets/sample/4.jpeg',
    'assets/sample/5.jpeg',
    'assets/sample/6.jpeg',
    'assets/sample/7.jpeg',
    'assets/sample/8.jpeg',
    'assets/sample/9.jpeg',
    'assets/sample/10.jpeg',
  ];
}
