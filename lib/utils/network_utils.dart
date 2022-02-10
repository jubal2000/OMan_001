
import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:oman_001/data/app_data.dart';
import 'package:oman_001/data/user_item.dart';

var funcGetStartInfoItem    = 'getStartInfoItem';
var funcGetUserItem         = 'getUserItem';
var funcGetMainData         = 'getMainData';

Future<UserItem> getStartInfo(deviceType) async {
  // print('--> getStartInfo : ${AppData.deviceType}');
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(funcGetStartInfoItem);
  final resp = await callable.call(<String, dynamic>{
    'deviceType': AppData.deviceType,
  });
  print("--> getStartInfo.data: ${resp.data.toString()}");
  AppData.startInfo = StartInfo.fromJson(resp.data);
  // var loginId = auth.currentUser?.uid;
  const loginId = "user0005@mail.kr";
  return getUserInfo(loginId);
}

Future<UserItem> getUserInfo(loginId) async {
  print('--> getUserInfo : $loginId');
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(funcGetUserItem);
  final resp = await callable.call(<String, dynamic>{
    'loginId': loginId,
  });
  try {
    AppData.userInfo = UserItem.fromJson(jsonDecode(resp.data.toString()));
    print("  --> result: ${resp.data.toString()}");
  } catch (e) {
    print("  --> error: $e");
  }
  return AppData.userInfo!;
}

Future<StartInfo> getMainList() async {
  // print('--> getStartInfo : ${AppData.deviceType}');
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(funcGetMainData);
  final resp = await callable.call(<String, dynamic>{
    'deviceType': AppData.deviceType,
  });
  print("--> getStartInfo.data: ${resp.data.toString()}");
  return StartInfo.fromJson(resp.data);
}
