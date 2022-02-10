

class SearchItem {
  String? id;
  int?    status;      // 0: remove  1: bid  2: waiting 3: accept  4: trans ready  5: trans done
  String? userId;
  String? desc;
  DateTime? createTime;

  //------------------------------------------------

  String? searchTab;

  SearchItem(
      this.id,
      this.status,
      this.userId,
      this.desc,
      this.createTime,
      );

  SearchItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'       ]!;
      status      = int.parse(json['status']!.toString());
      userId      = json['userId'   ]!;
      desc        = json['desc'     ]!;
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> SearchItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'         ] = id;
    data['status'     ] = status;
    data['userId'     ] = userId;
    data['desc'       ] = desc;
    data['createTime' ] = createTime;
    return data;
  }
}
