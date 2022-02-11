import 'package:oman_001/utils/utils.dart';
import 'user_item.dart';

class HomeItem {
  String? id;
  UserItem? user;
  UserItem? creator;

  HomeItem(
      this.id,
      this.user,
      this.creator,
      );

  HomeItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id      = STR(json['id']);
      user    = UserItem.fromJson(json['owner'  ]!);
      creator = UserItem.fromJson(json['creator']!);
    } catch (e) {
      print("--> HomeItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'  ] ??= id;
    data['user'] ??= user;
    return data;
  }
}

class HomeItemEx {
  String? id;
  int?    status;
  String? targetType;
  String? targetId;
  String? userId;

  //--------------------------------

  UserItem? user;

  HomeItemEx(
      this.id,
      this.status,
      this.targetType,
      this.targetId,
      );

  HomeItemEx.fromJson(Map<dynamic, dynamic> json) {
    var q = json['user'];
    if (q == null || q['id'] == null) return;
    try {
      id          = q['id'         ]!;
      status      = int.parse(q['status']!.toString());
      targetType  = q['targetType' ]!;
      targetId    = q['targetId'   ]!;
      userId      = q['userId'     ]!;
    } catch (e) {
      print("--> HomeItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'         ] ??= id;
    data['status'     ] ??= status;
    data['targetType' ] ??= targetType;
    data['targetId'   ] ??= targetId;
    data['userId'     ] ??= userId;
    return data;
  }
}
