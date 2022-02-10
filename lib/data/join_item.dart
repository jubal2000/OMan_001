class JoinItem {
  String? id;
  int?    status;           //  0: join,  1: delete
  String? message;
  DateTime? createTime;

  JoinItem(
      this.id,
      this.status,
      this.message,
      this.createTime,
      );

  JoinItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'       ]!.toString();
      status      = int.parse(json['status']!.toString());
      message     = json['message'  ]!;
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> JoinItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'         ] ??= id;
    data['status'     ] ??= status;
    data['message'    ] ??= message;
    data['createTime' ] ??= createTime.toString();
    return data;
  }
}
