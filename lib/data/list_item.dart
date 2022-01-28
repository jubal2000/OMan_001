class ListItem {
  int? id;
  int? status;
  int? type;
  int? targetId;
  String? title;
  String? desc;
  String? url;
  String? image;
  DateTime? expireTime;
  DateTime? createTime;


  ListItem(
      this.id,
      this.status,
      {
        this.type,
        this.title,
        this.desc,
        this.url,
        this.image,
        this.expireTime,
        this.createTime,
      }
  );

  ListItem.fromJson(Map<dynamic, dynamic> json) {
    try {
      id        = int.parse(json['id'     ].toString());
      status    = int.parse(json['status' ].toString());
      type      = int.parse(json['type'   ].toString());
      title     = json['title']!;
      desc      = json['desc']!;
      url       = json['url']!;
      image     = json['image']!;
      expireTime  = DateTime.parse(json['expireTime']!.toString());
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> ListItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id']      ??= id;
    data['status']  ??= status;
    data['type']    ??= type;
    data['title']   ??= title;
    data['desc']    ??= desc;
    data['url']     ??= url;
    data['image']   ??= image;
    data['expireTime']   ??= expireTime;
    data['createTime']   ??= createTime;
    return data;
  }
}
