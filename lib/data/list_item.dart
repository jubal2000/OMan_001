class ListItem {
  String? id;
  int?    status;
  int?    type;
  String? targetId;
  String? title;
  String? desc;
  String? url;
  String? image;
  int?    quantity;

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
        this.quantity,

        this.expireTime,
        this.createTime,
      }
  );

  ListItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id        = json['id'       ]!;
      status    = int.parse(json['status' ]!.toString());
      type      = int.parse(json['type'   ]!.toString());
      title     = json['title'    ]!;
      desc      = json['desc'     ]!;
      url       = json['url'      ]!;
      image     = json['image'    ]!;
      quantity  = json['quantity' ]!;

      expireTime  = DateTime.parse(json['expireTime']!.toString());
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> ListItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'         ] ??= id;
    data['status'     ] ??= status;
    data['type'       ] ??= type;
    data['title'      ] ??= title;
    data['desc'       ] ??= desc;
    data['url'        ] ??= url;
    data['image'      ] ??= image;
    data['quantity'   ] ??= quantity;

    data['expireTime' ] ??= expireTime;
    data['createTime' ] ??= createTime;
    return data;
  }
}
