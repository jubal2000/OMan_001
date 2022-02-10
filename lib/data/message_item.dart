

class MessageItem {
  String? id;
  int?    status;
  String? targetType;
  String? targetId;
  String? userId;
  String? userName;
  String? userPic;
  String? desc;
  DateTime? createTime;

  //----------------------------------------------------------------

  MessageItem(
      this.id,
      this.status,
      this.userId,
      this.userName,
      this.userPic,
      {
        this.desc,
        this.createTime,
      });

  MessageItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'         ]!;
      status      = int.parse(json['status']!.toString());
      targetType  = json['targetType' ]!;
      targetId    = json['targetId'   ]!;
      userId      = json['userId'     ]!;
      userName    = json['userName'   ]!;
      userPic     = json['userPic'    ]!;
      desc        = json['desc'       ]!;
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> MessageItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'         ] ??= id;
    data['status'     ] ??= status;
    data['targetType' ] ??= targetType;
    data['targetId'   ] ??= targetId;
    data['userId'     ] ??= userId;
    data['userName'   ] ??= userName;
    data['userPic'    ] ??= userPic;
    data['desc'       ] ??= desc;
    data['createTime' ] ??= createTime;
    return data;
  }
}
