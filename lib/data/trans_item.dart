

class TransItem {
  int? id;
  int? status;
  int? type;
  int? targetId;
  int? userId;
  String? number;
  String? codeId;
  String? token;
  DateTime? createTime;

  TransItem(
      this.id,
      this.status,
      this.type,
      this.targetId,
      this.userId,
      this.number,
      this.codeId,
      this.token,
      this.createTime,
      );

  TransItem.fromJson(Map<dynamic, dynamic> json) {
    try {
      id          = int.parse(json['id'       ].toString());
      status      = int.parse(json['status'   ].toString());
      type        = int.parse(json['type'     ].toString());
      targetId    = int.parse(json['targetId' ].toString());
      userId      = int.parse(json['userId'   ].toString());
      number      = json['number']!;
      codeId      = json['codeId']!;
      token       = json['token']!;
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> TransItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id']          ??= id;
    data['status']      ??= status;
    data['type']        ??= type;
    data['targetId']    ??= targetId;
    data['userId']      ??= userId;
    data['number']      ??= number;
    data['codeId']      ??= codeId;
    data['token']       ??= token;
    data['createTime']  ??= createTime;
    return data;
  }
}
