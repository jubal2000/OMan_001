

class CategoryItem {
  String? id;
  int?    status;
  String? parentId;
  String? title;
  String? image;

  CategoryItem(
      this.id,
      this.status,
      this.parentId,
      this.title,
      this.image,
      );

  CategoryItem.fromJson(Map<dynamic, dynamic> json) {
    if (json['id'] == null) return;
    try {
      id        = json['id'       ]!;
      status    = int.parse(json['status']!.toString());
      parentId  = json['parentId' ]!;
      title     = json['title'    ]!;
      image     = json['image'    ]!;
    } catch (e) {
      print("--> CategoryItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'       ] ??= id;
    data['status'   ] ??= status;
    data['parentId' ] ??= parentId;
    data['title'    ] ??= title;
    data['image'    ] ??= image;
    return data;
  }
}
