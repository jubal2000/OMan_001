class SocialItem {
  int? id;
  int? status;
  int? type;
  String? title;
  String? url;
  String? image;

  SocialItem(
      this.id,
      this.status,
      this.type,
      this.title,
      this.url,
      this.image,
      );

  SocialItem.fromJson(Map<dynamic, dynamic> json) {
    try {
      id        = int.parse(json['id'     ].toString());
      status    = int.parse(json['status' ].toString());
      type      = int.parse(json['type'   ].toString());
      title     = json['title']!;
      url       = json['url']!;
      image     = json['image']!;
    } catch (e) {
      print("--> SocialItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id']      ??= id;
    data['status']  ??= status;
    data['type']    ??= type;
    data['title']   ??= title;
    data['url']     ??= url;
    data['image']   ??= image;
    return data;
  }
}
