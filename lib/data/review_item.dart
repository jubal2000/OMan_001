

class ReviewItem {
  int? id;
  int? status;
  int? targetId; // goods or talent id..
  int? userId;
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
    try {
      id          = int.parse(json['id'       ].toString());
      status      = int.parse(json['status'   ].toString());
      targetId    = int.parse(json['targetId' ].toString());
      userId      = int.parse(json['userId'   ].toString());
      desc        = json['desc']!;
      url         = json['url']!;

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
    data['id']          ??= id;
    data['status']      ??= status;
    data['targetId']    ??= targetId;
    data['userId']      ??= userId;
    data['desc']        ??= desc;
    data['url']         ??= url;
    data['imageData']   ??= imageData;
    data['createTime']  ??= createTime;
    return data;
  }
}
