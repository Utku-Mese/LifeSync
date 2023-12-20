class Recipe{
  String? title;
  String? contents;
  String? recipe
  String? thumbnail;
  String? source;
  String? video;
  Recipe({
    
    this.title, 
    this.contents, 
    this.recipe, 
    this.thumbnail, 
    this.source,
    this.video
    });
    Recipe.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    contents = json['contents'];
    recipe = json['recipe'];
    thumbnail = json['thumbnail'];
    source = json['source'];
    video = json['source'];
  }
    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['contents'] = contents;
    data['recipe'] = recipe;
    data['thumbnail'] = thumbnail;
    data['source'] = source;
    data['video'] = video;
    return data;
  } 
}