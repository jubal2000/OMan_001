

class CategoryItem {
  int? id;
  int? status;
  int? parentId;
  String? title;
  String? image;

  CategoryItem(
      this.id,
      this.status,
      this.title,
      this.image,
      );

  CategoryItem.fromJson(Map<dynamic, dynamic> json) {
    try {
      id        = int.parse(json['id'       ].toString());
      status    = int.parse(json['status'   ].toString());
      parentId  = int.parse(json['parentId' ].toString());
      title     = json['title']!;
      image     = json['image']!;
    } catch (e) {
      print("--> CategoryItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id']        ??= id;
    data['status']    ??= status;
    data['parentId']  ??= parentId;
    data['title']     ??= title;
    data['image']     ??= image;
    return data;
  }
}
