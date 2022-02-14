
import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:oman_001/data/app_data.dart';
import 'package:oman_001/data/home_item.dart';
import 'package:oman_001/data/user_item.dart';

var funcGetStartInfoItem    = 'getStartInfoItem'; // app start info..
var funcGetUserItem         = 'getUserItem';      // user info..
var funcGetMainHomeData     = 'getMainHomeData';  // main home list data..


//----------------------------------------------------------------------------------------
//
//    get start info..
//

Future<StartInfo> getStartInfo(deviceType) async {
  // print('--> getStartInfo : ${AppData.deviceType}');
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(funcGetStartInfoItem);
  final resp = await callable.call(<String, dynamic>{
    'deviceType': AppData.deviceType,
  });
  print("--> getStartInfo.data: ${resp.data.toString()}");
  AppData.startInfo = StartInfo.fromJson(resp.data);
  // var loginId = auth.currentUser?.uid;
  // const loginId = "user0005@mail.kr";
  // return getUserInfo(loginId);
  return AppData.startInfo!;
}

//----------------------------------------------------------------------------------------
//
//    get user info..
//

Future<UserItem> getUserInfo(loginId) async {
  print('--> getUserInfo : $loginId');
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(funcGetUserItem);
  final resp = await callable.call(<String, dynamic>{
    'loginId': loginId,
  });
  AppData.userInfo = UserItem.fromJson(jsonDecode(resp.data.toString()));
  print('--> AppData.userInfo : ${AppData.userInfo!.loginId}');
  return AppData.userInfo!;
}

//----------------------------------------------------------------------------------------
//
//    get main home info..
//

Future<List<HomeItem>> getMainHomeData() async {
  print('--> getMainHomeData : ${AppData.userInfo!.loginId}');
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(funcGetMainHomeData);
  final resp = await callable.call(<String, dynamic>{
    'loginId': AppData.userInfo!.loginId,
  });
  // print("--> getMainHomeData.data: ${resp.data.toString()}");
  List<HomeItem> result = [];
  for (var item in resp.data) {
    try {
      result.add(HomeItem.fromJson(item));
      // print("  --> getMainHomeData result: $item");
    } catch (e) {
      print("  --> getMainHomeData error: $e");
    }
  }
  // print("  --> getMainHomeData result: ${jsonDecode(result.toString())}");
  return result;
}
