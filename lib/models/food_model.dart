
class Food {
  String? isApproved;
  String? type;
  String? name;
  String? calories;
  String? fat;
  String? protein;
  String? carbohydrate;

  Food(
      {this.isApproved,
      this.type,
      this.name,
      this.calories,
      this.fat,
      this.protein,
      this.carbohydrate});

  Food.fromJson(Map<String, dynamic> json) {
    isApproved = json['IsApproved'];
    type = json['Type'];
    name = json['Name'];
    calories = json['Calories'];
    fat = json['Fat'];
    protein = json['Protein'];
    carbohydrate = json['Carbohydrate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsApproved'] = isApproved;
    data['Type'] = type;
    data['Name'] = name;
    data['Calories'] = calories;
    data['Fat'] = fat;
    data['Protein'] = protein;
    data['Carbohydrate'] = carbohydrate;
    return data;
  }
}
