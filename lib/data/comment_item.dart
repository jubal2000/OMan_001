class CommentItem {
  String? id;
  int?    status;
  String? targetType; // 0: user, 1: content, 2: goods, 3: shop, 4: message...
  String? targetId;
  String? userId;
  int?    vote;
  String? message;
  DateTime? createTime;

  CommentItem(
      this.id,
      this.status,
      this.targetType,
      this.targetId,
      this.userId,
      this.vote,
      this.message,
      this.createTime,
      );

  CommentItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'       ]!;
      status      = int.parse(json['status'     ]!.toString());
      targetType  = json['targetType' ]!;
      targetId    = json['targetId'   ]!;
      userId      = json['userId'     ]!;
      message     = json['message'    ]!;
      vote        = int.parse(json['vote']!.toString());
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> CommentItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'         ] ??= id;
    data['status'     ] ??= status;
    data['targetType' ] ??= targetType;
    data['targetId'   ] ??= targetId;
    data['userId'     ] ??= userId;
    data['vote'       ] ??= vote;
    data['message'    ] ??= message;
    data['createTime' ] ??= createTime;
    return data;
  }
}
