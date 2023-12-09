//xx
class Sport {
    String? name;
    String? type;
    Int? calories;

    Sport({
        this.name,
        this.type,
        this.calories,
    })
    Sport.fromJson(Map<String,dynamic>){
        name = json['name'];
        type = json['type'];
        calories = json['calories'];
    }
    Map<String,dynamic> toJson() {
        final Map<String,dynamic> data = new Map<String,dynamic>();
            data['name'] = this.name;
            data['type'] = this.type;
            data['calories'] = this.calories;
            return data;
    }
}