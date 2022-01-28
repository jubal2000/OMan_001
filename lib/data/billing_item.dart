

class BillingItem {
  int? id;
  int? status;
  int? type;
  int? userId;
  String? number;
  String? date;
  String? name;
  String? password;
  String? codeId;
  String? token;
  DateTime? createTime;

  BillingItem(
      this.id,
      this.status,
      this.type,
      this.userId,
      this.number,
      this.date,
      this.name,
      this.password,
      this.codeId,
      this.token,
      this.createTime,
      );

  BillingItem.fromJson(Map<dynamic, dynamic> json) {
    try {
      id          = int.parse(json['id'       ].toString());
      status      = int.parse(json['status'   ].toString());
      type        = int.parse(json['type'     ].toString());
      userId      = int.parse(json['userId'   ].toString());
      number      = json['number']!;
      date        = json['date']!;
      name        = json['name']!;
      password    = json['password']!;
      codeId      = json['codeId']!;
      token       = json['token']!;
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> BillingItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id']        ??= id;
    data['status']    ??= status;
    data['type']      ??= type;
    data['userId']    ??= userId;
    data['number']    ??= number;
    data['date']      ??= date;
    data['name']      ??= name;
    data['password']  ??= password;
    data['codeId']    ??= codeId;
    data['token']     ??= token;
    data['createTime']   ??= createTime;
    return data;
  }
}
