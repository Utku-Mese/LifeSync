//xx
class News {
    String? title;
    String? contents;
    String? thumpnail;
    Date? datetime;
    String? source;

    News({
        this.title,
        this.contents,
        this.thumpnail,
        this.datetime,
        this.source
    })
    News.fromJson(Map<String,dynamic> json){
        title = json['title'];
        contents = json['contents'];
        thumpnail = json['thumpnail'];
        datetime = json['datetime'];
        source = json['source'];
    }
    Map<String,dynamic> toJson(){
        final Map<String,dynamic> data = new Map<String,dynamic>();
        data['title'] = this.title;
        data['contents'] = this.contents;
        data['thumpnail'] = this.thumpnail;
        data['datetime'] = this.datetime;
        data['source'] = this.source;
        return data;
    }
}
