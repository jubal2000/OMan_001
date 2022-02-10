

import 'cart_item.dart';

class OrderItem {
  String? id;
  int?    status;      // 0: remove  1: normal  2: billing done
  int?    targetType;  // 0: content..
  String? targetId;
  String? userId;
  String? addressId;
  String? billingId;
  double? price;        // price
  double? priceTotal;   // total price (price + transPee)
  double? transPee;     // trans pee
  String? message;
  Map<String, CartItem>? cartData;
  DateTime? createTime;

  OrderItem(
      this.id,
      this.status,
      this.targetType,
      this.targetId,
      this.userId,
      this.addressId,
      this.billingId,
      this.price,
      this.priceTotal,
      this.transPee,
      this.message,
      this.cartData,
      this.createTime,
      );

  OrderItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'       ]!;
      status      = int.parse(json['status'     ]!.toString());
      targetType  = int.parse(json['targetType' ]!.toString());
      targetId    = json['targetId' ]!;
      userId      = json['userId'   ]!;
      addressId   = json['addressId']!;
      billingId   = json['billingId']!;
      price       = double.parse(json['price'     ]!.toString());
      priceTotal  = double.parse(json['priceTotal']!.toString());
      transPee    = double.parse(json['transPee'  ]!.toString());
      message     = json['message'  ]!;

      cartData = {};
      for (var item in json['cartData']!) {
        var itemId = item['id'].toString();
        cartData![itemId] ??= CartItem.fromJson(item);
      }

      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> OrderItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'         ] = id;
    data['status'     ] = status;
    data['targetType' ] = targetType;
    data['targetId'   ] = targetId;
    data['userId'     ] = userId;
    data['addressId'  ] = addressId;
    data['billingId'  ] = billingId;
    data['price'      ] = price;
    data['priceTotal' ] = priceTotal;
    data['transPee'   ] = transPee;
    data['message'    ] = message;
    data['cartData'   ] = cartData;
    data['createTime' ] = createTime;
    return data;
  }
}
