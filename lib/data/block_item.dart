

class BlockItem {
  String? id;
  int? status;
  String? targetType;
  String? targetId;
  String? userId;
  String? desc;
  String? url;
  DateTime? createTime;

  BlockItem(
      this.id,
      this.status,
      this.targetType,
      this.targetId,
      this.userId,
      this.desc,
      this.url,
      this.createTime,
      );

  BlockItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'         ]!;
      status      = int.parse(json['status']!.toString());
      targetType  = json['targetType' ]!;
      targetId    = json['targetId'   ]!;
      userId      = json['userId'     ]!;
      desc        = json['desc'       ]!;
      url         = json['url'        ]!;
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> BlockItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'           ] ??= id;
    data['status'       ] ??= status;
    data['targetType'   ] ??= targetType;
    data['targetId'     ] ??= targetId;
    data['userId'       ] ??= userId;
    data['desc'         ] ??= desc;
    data['url'          ] ??= url;
    data['createTime'   ] ??= createTime;
    return data;
  }
}
