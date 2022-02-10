

class StoreItem {
  String? id;
  int   ? status;
  String? userId;
  String? title;    // shop title..
  String? desc;     // shop message..
  DateTime? createTime;

  StoreItem(
      this.id,
      this.status,
      this.userId,
      {
        this.title,
        this.desc,
        this.createTime,
      }
  );

  StoreItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'       ]!;
      status      = json['status'   ]!;
      userId      = json['userId'   ]!;
      title       = json['title'    ]!;
      desc        = json['desc'     ]!;
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> StoreItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'         ] ??= id;
    data['userId'     ] ??= userId;
    data['title'      ] ??= title;
    data['desc'       ] ??= desc;
    data['createTime' ] ??= createTime;
    return data;
  }
}
