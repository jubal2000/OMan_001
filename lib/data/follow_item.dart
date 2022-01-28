class FollowItem {
  int? id;
  int? status; // 1: normal  0: block
  int? targetId;
  int? userId;
  int? type;
  String? name;
  String? pic;
  DateTime? createTime;

  FollowItem(
      this.id,
      this.targetId,
      this.userId,
      this.type,
      this.name,
      this.pic,
      this.createTime,
      );

  FollowItem.fromJson(Map<dynamic, dynamic> json) {
    try {
      id          = int.parse(json['id'].toString());
      status      = int.parse(json['status'].toString());
      targetId    = int.parse(json['targetId'].toString());
      userId      = int.parse(json['userId'].toString());
      type        = int.parse(json['type'].toString());
      name        = json['name']!;
      pic         = json['pic']!;
      createTime  = DateTime.parse(json['type'].toString());
    } catch (e) {
      print("--> FollowItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id']          = id;
    data['status']      = status;
    data['targetId']    = targetId;
    data['userId']      = userId;
    data['type']        = type;
    data['name']        = name;
    data['pic']         = pic;
    data['createTime']  = createTime;
    return data;
  }
}
