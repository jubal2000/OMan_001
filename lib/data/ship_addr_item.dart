

class ShipAddrItem {
  int? id;
  int? status;
  int? userId;
  String? address1;
  String? address2;
  String? name;
  String? postCode;
  String? city;
  String? country;
  String? phone;
  DateTime? createTime;

  ShipAddrItem(
      this.id,
      this.status,
      this.userId,
      {
        this.address1,
        this.address2,
        this.name,
        this.postCode,
        this.city,
        this.country,
        this.phone,
        this.createTime,
      }
    );

  ShipAddrItem.fromJson(Map<dynamic, dynamic> json) {
    try {
      id          = int.parse(json['id'       ].toString());
      status      = int.parse(json['status'   ].toString());
      userId      = int.parse(json['userId'   ].toString());
      address1    = json['address1']!;
      address2    = json['address2']!;
      name        = json['name']!;
      postCode    = json['postCode']!;
      city        = json['city']!;
      country     = json['country']!;
      phone       = json['phone']!;
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> ShipAddrItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id']          ??= id;
    data['status']      ??= status;
    data['userId']      ??= userId;
    data['address1']    ??= address1;
    data['address2']    ??= address2;
    data['name']        ??= name;
    data['postCode']    ??= postCode;
    data['city']        ??= city;
    data['country']     ??= country;
    data['phone']       ??= phone;
    data['createTime']  ??= createTime;
    return data;
  }
}
