

class AddressItem {
  String? id;
  int?    status;
  String? userId;
  String? title;              // address title..
  String? address1;
  String? address2;
  String? recName;       // receiver name..
  String? postCode;
  String? city;
  String? country;
  String? phone;
  DateTime? createTime;

  AddressItem(
      this.id,
      this.status,
      this.userId,
      {
        this.title,
        this.address1,
        this.address2,
        this.recName,
        this.postCode,
        this.city,
        this.country,
        this.phone,
        this.createTime,
      }
    );

  AddressItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'       ]!;
      status      = int.parse(json['status']!.toString());
      title       = json['title'    ]!;
      userId      = json['userId'   ]!;
      address1    = json['address1' ]!;
      address2    = json['address2' ]!;
      recName     = json['recName'  ]!;
      postCode    = json['postCode' ]!;
      city        = json['city'     ]!;
      country     = json['country'  ]!;
      phone       = json['phone'    ]!;
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> AddressItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'         ] ??= id;
    data['status'     ] ??= status;
    data['userId'     ] ??= userId;
    data['title'      ] ??= title;
    data['address1'   ] ??= address1;
    data['address2'   ] ??= address2;
    data['recName'    ] ??= recName;
    data['postCode'   ] ??= postCode;
    data['city'       ] ??= city;
    data['country'    ] ??= country;
    data['phone'      ] ??= phone;
    data['createTime' ] ??= createTime;
    return data;
  }
}
