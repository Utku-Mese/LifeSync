class Sport {
  String? name;
  String? type;
  int? calories;

  Sport({
    this.name,
    this.type,
    this.calories,
  });

  Sport.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    calories = json['calories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['calories'] = calories;
    return data;
  }
}
