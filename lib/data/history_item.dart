class HistoryItem {
  String? id;
  String? title;
  String? desc;
  String? url;
  int   ? likes;
  int   ? type;    // 0: photo, 1: video, 2: music
  List<String>? commentData;

  HistoryItem(
      this.id,
      this.title,
      {
        this.desc,
        this.url,
        this.likes,
        this.type,
        this.commentData
      });

  HistoryItem.fromJson(Map<dynamic, dynamic> json) {
    try {
      id        = json['id'   ];
      title     = json['title'];
      desc      = json['desc' ];
      url       = json['url'  ];
      likes     = int.parse(json['likes'].toString());
      type      = int.parse(json['type' ].toString());

      commentData = [];
      for (var item in json['comments']) {
        commentData?.add(item);
      }
    } catch (e) {
      print("--> HistoryItem error : $id -> $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id']        = id;
    data['title']     = title;
    data['desc']      = desc;
    data['url']       = url;
    data['likes']     = likes;
    data['type']      = type;
    data['comments']  = commentData;
    return data;
  }
}
