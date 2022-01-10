import 'user_item.dart';

class HomeItem {
  UserItem? user;
  String? historyId;

  HomeItem.fromJson(Map<dynamic, dynamic> json) :
        user          = UserItem.fromJson(json['user']),
        historyId     = json['historyId'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user']      = user;
    data['historyId'] = historyId;
    return data;
  }
}
