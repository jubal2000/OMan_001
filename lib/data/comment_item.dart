class CommentItem {
  int? id;
  int? status;
  int? targetType; // 0: user, 1: content, 2: goods, 3: shop, 4: message...
  int? targetId;
  int? userId;
  int? vote;
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
    try {
      id          = int.parse(json['id'].toString());
      status      = int.parse(json['status'].toString());
      targetType  = int.parse(json['targetType'].toString());
      targetId    = int.parse(json['targetId'].toString());
      userId      = int.parse(json['userId'].toString());
      vote        = int.parse(json['vote'].toString());
      message     = json['message']!;
      createTime  = DateTime.parse(json['type'].toString());
    } catch (e) {
      print("--> CommentItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id']          = id;
    data['status']      = status;
    data['targetType']  = targetType;
    data['targetId']    = targetId;
    data['userId']      = userId;
    data['vote']        = vote;
    data['message']     = message;
    data['createTime']  = createTime;
    return data;
  }
}
