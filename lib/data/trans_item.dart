

class TransItem {
  String? id;
  int?    status;
  String? transType;
  String? targetId;
  String? userId;
  String? number;
  String? codeId;
  String? token;
  DateTime? createTime;

  TransItem(
      this.id,
      this.status,
      this.transType,
      this.targetId,
      this.userId,
      this.number,
      this.codeId,
      this.token,
      this.createTime,
      );

  TransItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'         ]!;
      status      = int.parse(json['status'   ]!.toString());
      transType   = json['transType'  ]!;
      targetId    = json['targetId'   ]!;
      userId      = json['userId'     ]!;
      number      = json['number'     ]!;
      codeId      = json['codeId'     ]!;
      token       = json['token'      ]!;
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> TransItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'         ] ??= id;
    data['status'     ] ??= status;
    data['transType'  ] ??= transType;
    data['targetId'   ] ??= targetId;
    data['userId'     ] ??= userId;
    data['number'     ] ??= number;
    data['codeId'     ] ??= codeId;
    data['token'      ] ??= token;
    data['createTime' ] ??= createTime;
    return data;
  }
}

class TransTypeItem {
  String? id;
  int?    status;
  String? title;
  String? desc;
  String? image;
  double? transPee;

  TransTypeItem(
      this.id,
      this.status,
      this.title,
      this.desc,
      this.image,
      this.transPee,
      );

  TransTypeItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'       ]!;
      status      = int.parse(json['status'   ]!.toString());
      title       = json['title'    ]!;
      desc        = json['desc'     ]!;
      image       = json['image'   ]!;
      transPee    = double.parse(json['transPee']!.toString());
    } catch (e) {
      print("--> TransTypeItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'       ] ??= id;
    data['status'   ] ??= status;
    data['title'    ] ??= title;
    data['desc'     ] ??= desc;
    data['image'    ] ??= image;
    data['transPee' ] ??= transPee;
    return data;
  }
}

