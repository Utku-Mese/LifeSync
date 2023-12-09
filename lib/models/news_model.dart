//xx
class News {
    String? title;
    String? contents;
    String? thumpnail;
    Date? datetime;

    News({
        this.title,
        this.contents,
        this.thumpnail,
        this.datetime
    })
    News.fromJson(Map<String,dynamic> json){
        title = json['title'];
        contents = json['contents'];
        thumpnail = json['thumpnail'];
        datetime = json['datetime'];
    }
    Map<String,dynamic> toJson(){
        final Map<String,dynamic> data = new Map<String,dynamic>();
        data['title'] = this.title;
        data['contents'] = this.contents;
        data['thumpnail'] = this.thumpnail;
        data['datetime'] = this.datetime;
        return data;
    }
}
