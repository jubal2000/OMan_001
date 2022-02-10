class SocialItem {
  String? id;
  int?    status;
  int?    type;
  String? title;
  String? url;
  String? image;
  DateTime? createTime;

  SocialItem(
      this.id,
      this.status,
      this.type,
      this.title,
      this.url,
      this.image,
      this.createTime,
      );

  SocialItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'     ]!;
      status      = int.parse(json['status' ]!.toString());
      type        = int.parse(json['type'   ]!.toString());
      title       = json['title'  ]!;
      url         = json['url'    ]!;
      image       = json['image'  ]!;
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> SocialItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'         ] ??= id;
    data['status'     ] ??= status;
    data['type'       ] ??= type;
    data['title'      ] ??= title;
    data['url'        ] ??= url;
    data['image'      ] ??= image;
    data['createTime' ] ??= createTime;
    return data;
  }
}
