

class BlockItem {
  int? id;
  int? status;
  int? targetId;
  int? userId;
  String? title;
  String? desc;
  String? url;
  DateTime? createTime;

  BlockItem(
      this.id,
      this.status,
      this.targetId,
      this.userId,
      this.title,
      this.desc,
      this.url,
      this.createTime,
      );

  BlockItem.fromJson(Map<dynamic, dynamic> json) {
    try {
      id          = int.parse(json['id'       ].toString());
      status      = int.parse(json['status'   ].toString());
      targetId    = int.parse(json['targetId' ].toString());
      userId      = int.parse(json['userId'   ].toString());
      title       = json['title']!;
      desc        = json['desc']!;
      url         = json['url']!;
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> BlockItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id']        ??= id;
    data['status']    ??= status;
    data['targetId']  ??= targetId;
    data['userId']    ??= userId;
    data['title']     ??= title;
    data['desc']      ??= desc;
    data['url']       ??= url;
    data['createTime']   ??= createTime;
    return data;
  }
}
