

class CouponItem {
  String? id;
  int?    status;
  String? title;
  String? desc;
  String? url;
  String? image;
  double?  saleRatio;
  double?  salePrice;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? createTime;

  CouponItem(
      this.id,
      this.status,
      this.title,
      this.desc,
      this.url,
      this.image,
      this.saleRatio,
      this.salePrice,
      this.startTime,
      this.endTime,
      this.createTime,
      );

  CouponItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'     ]!;
      status      = int.parse(json['status']!.toString());
      title       = json['title'  ]!;
      desc        = json['desc'   ]!;
      url         = json['url'    ]!;
      image       = json['image'  ]!;
      saleRatio   = double.parse(json['saleRatio'   ]!.toString());
      salePrice   = double.parse(json['salePrice'   ]!.toString());
      startTime   = DateTime.parse(json['startTime' ]!.toString());
      endTime     = DateTime.parse(json['endTime'   ]!.toString());
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> CouponItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'         ] ??= id;
    data['status'     ] ??= status;
    data['title'      ] ??= title;
    data['desc'       ] ??= desc;
    data['url'        ] ??= url;
    data['image'      ] ??= image;
    data['saleRatio'  ] ??= saleRatio;
    data['salePrice'  ] ??= salePrice;
    data['startTime'  ] ??= startTime;
    data['endTime'    ] ??= endTime;
    data['createTime' ] ??= createTime;
    return data;
  }
}
