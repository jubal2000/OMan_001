class ShopItem {
  String? id;
  int   ? status;
  String? userId;
  String? title;    // shop title..
  String? message;  // shop message..
  DateTime? createTime;

  ShopItem(
      this.id,
      this.status,
      this.userId,
      {
        this.title,
        this.message,
        this.createTime,
      }
  );

  ShopItem.fromJson(Map<dynamic, dynamic> json) {
    try {
      id          = json['id'       ];
      status      = json['status'   ];
      userId      = json['userId'   ];
      title       = json['title'    ];
      message     = json['message'  ];
      createTime  = DateTime.parse(json['createTime'].toString());
    } catch (e) {
      print("--> ShopItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id']          = id;
    data['userId']      = userId;
    data['title']       = title;
    data['message']     = message;
    data['createTime']  = createTime;
    return data;
  }
}
