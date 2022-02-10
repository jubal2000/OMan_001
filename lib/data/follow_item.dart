class FollowItem {
  String? id;
  int?    status; // 1: normal  0: block
  String? targetId;
  String? userId;
  int?    type;
  DateTime? createTime;

  //--------------------------------------------

  String name = "";
  String pic  = "";

  FollowItem(
      this.id,
      this.targetId,
      this.userId,
      this.type,
      this.createTime,
      );

  FollowItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'       ]!;
      status      = int.parse(json['status']!.toString());
      targetId    = json['targetId' ]!;
      userId      = json['userId'   ]!;
      type        = int.parse(json['type']!.toString());
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> FollowItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'         ] ??= id;
    data['status'     ] ??= status;
    data['targetId'   ] ??= targetId;
    data['userId'     ] ??= userId;
    data['type'       ] ??= type;
    data['createTime' ] ??= createTime;
    return data;
  }
}
