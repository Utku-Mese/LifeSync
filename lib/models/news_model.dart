class News {
  String? title;
  String? contents;
  String? thumpnail;
  String? datetime;
  String? source;

  News({this.title, this.contents, this.thumpnail, this.datetime, this.source});
  News.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    contents = json['contents'];
    thumpnail = json['thumbnail'];
    datetime = json['datetime'];
    source = json['source'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['contents'] = contents;
    data['thumbnail'] = thumpnail;
    data['datetime'] = datetime;
    data['source'] = source;
    return data;
  }
}
