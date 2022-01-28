class JoinItem {
  int? id;
  int? type;            //  0: join,  1: delete
  String? message;
  DateTime? createTime;

  JoinItem(
      this.id,
      this.type,
      this.message,
      this.createTime,
      );

  JoinItem.fromJson(Map<dynamic, dynamic> json) {
    try {
      id          = int.parse(json['id'   ].toString());
      type        = int.parse(json['type' ].toString());
      message     = json['message']!;
      createTime  = DateTime.parse(json['createTime'].toString());
    } catch (e) {
      print("--> JoinItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id']          = id;
    data['type']        = type;
    data['message']     = message;
    data['createTime']  = createTime.toString();
    return data;
  }
}
