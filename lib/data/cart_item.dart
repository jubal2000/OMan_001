

import 'package:oman_001/data/coupon_item.dart';
import 'package:oman_001/data/goods_item.dart';
import 'package:oman_001/data/list_item.dart';

class CartItem {
  String? id;
  int?    status;      // 0: remove  1: bid  2: waiting 3: accept  4: trans ready  5: trans done
  int?    targetType;  // 0: content..
  int?    targetId;
  String? userId;
  int?    quantity;
  Map<String, ListItem>? optionData;  // option list..
  DateTime? createTime;

  /////////////////////

  double priceTotal = 0.0;   // trans pee
  double price = 0.0;      // bid price
  double transPee = 0.0;   // trans pee
  GoodsItem? goodsItem;
  Map<String, CouponItem> couponData = {};  // use coupon list..

  CartItem(
      this.id,
      this.status,
      this.targetType,
      this.targetId,
      this.userId,
      this.quantity,
      this.optionData,
      this.createTime,
      );

  CartItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'       ]!;
      status      = int.parse(json['status'     ]!.toString());
      targetType  = int.parse(json['targetType' ]!.toString());
      targetId    = json['targetId' ]!;
      userId      = json['userId'   ]!;
      quantity    = json['quantity' ]!;

      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> CartItem error : $id -> $e");
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
    data['transPee'   ] = transPee;
    data['quantity'   ] = quantity;
    data['createTime' ] = createTime;
    return data;
  }
}
