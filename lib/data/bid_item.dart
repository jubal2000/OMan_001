

class BidItem {
  String? id;
  int?    status;      // 0: remove  1: bid  2: waiting 3: accept  4: trans ready  5: trans done
  int?    targetType;  // 0: content..
  String? targetId;
  String? userId;
  double? price;    // bid price
  String? message;
  DateTime? createTime;

  BidItem(
      this.id,
      this.status,
      this.targetType,
      this.targetId,
      this.userId,
      this.price,
      this.message,
      this.createTime,
      );

  BidItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'       ]!;
      status      = int.parse(json['status'     ]!.toString());
      targetType  = int.parse(json['targetType' ]!.toString());
      targetId    = json['targetId' ]!;
      userId      = json['userId'   ]!;
      message     = json['message'  ]!;
      price       = double.parse(json['price']!.toString());
      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> BidItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'         ] = id;
    data['status'     ] = status;
    data['targetType' ] = targetType;
    data['targetId'   ] = targetId;
    data['userId'     ] = userId;
    data['price'      ] = price;
    data['message'    ] = message;
    data['createTime' ] = createTime;
    return data;
  }
}
