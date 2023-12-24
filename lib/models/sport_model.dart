class Sport {
  String? name;
  int? calories;

  Sport({
    this.name,
    this.calories,
  });

  Sport.fromJson(Map<String, dynamic> json) {
    name = json['sportName'];
    calories = json['kalori/saat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['calories'] = calories;
    return data;
  }
}
