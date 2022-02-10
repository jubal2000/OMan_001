

class PortfolioItem {
  String? id;
  int?    status;
  String? type;
  String? userId;
  String? title;          // address title..
  String? desc;

  List<String>? urlData;

  DateTime? createTime;

  PortfolioItem(
      this.id,
      this.status,
      this.type,
      this.userId,
      {
        this.title,
        this.desc,
        this.urlData,
        this.createTime,
      }
    );

  PortfolioItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id          = json['id'       ]!;
      status      = int.parse(json['status']!.toString());
      type        = json['type'     ]!;
      userId      = json['userId'   ]!;
      title       = json['title'    ]!;
      desc        = json['desc'     ]!;

      urlData = [];
      for (var item in json['urlData']!) {
        urlData!.add(item['value']!.toString());
      }

      createTime  = DateTime.parse(json['createTime']!.toString());
    } catch (e) {
      print("--> PortfolioItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'         ] ??= id;
    data['status'     ] ??= status;
    data['type'       ] ??= type;
    data['userId'     ] ??= userId;
    data['title'      ] ??= title;
    data['desc'       ] ??= desc;
    data['urlData'    ] ??= urlData;
    data['createTime' ] ??= createTime;
    return data;
  }
}
