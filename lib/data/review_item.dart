

class ReviewItem {
  String? id;
  int?    status;
  String? targetType;
  String? targetId; // goods or talent id..
  String? userId;
  String? desc;
  String? url;
  List<String>? imageData;
  DateTime? createTime;

  ReviewItem(
      this.id,
      this.status,
      this.targetId,
      this.userId,
      this.desc,
      this.url,
      this.createTime,
      );

  ReviewItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'         ]!;
      status      = int.parse(json['status']!.toString());
      targetType  = json['targetType' ]!;
      targetId    = json['targetId'   ]!;
      userId      = json['userId'     ]!;
      desc        = json['desc'       ]!;
      url         = json['url'        ]!;

      imageData = [];
      for (var item in json['images']!) {
        imageData!.add(item.toString());
      }

      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> ReviewItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'         ] ??= id;
    data['status'     ] ??= status;
    data['targetType' ] ??= targetType;
    data['targetId'   ] ??= targetId;
    data['userId'     ] ??= userId;
    data['desc'       ] ??= desc;
    data['url'        ] ??= url;
    data['imageData'  ] ??= imageData;
    data['createTime' ] ??= createTime;
    return data;
  }
}
