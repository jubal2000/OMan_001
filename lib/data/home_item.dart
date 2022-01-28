import 'user_item.dart';

class HomeItem {
  String? id;
  UserItem? user;

  HomeItem(
      this.id,
      this.user
      );

  HomeItem.fromJson(Map<dynamic, dynamic> json) {
    try {
      id = json['id'];
      user = UserItem.fromJson(json['user']);
    } catch (e) {
      print("--> HomeItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id']      = id;
    data['user']    = user;
    return data;
  }
}
