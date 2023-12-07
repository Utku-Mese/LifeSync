//xx
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
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['IsApproved'] = this.isApproved;
      data['Type'] = this.type;
      data['Name'] = this.name;
      data['Calories'] = this.calories;
      data['Fat'] = this.fat;
      data['Protein'] = this.protein;
      data['Carbohydrate'] = this.carbohydrate;
      return data;
    }
  }
  