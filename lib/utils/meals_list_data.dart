class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? meals;
  int kacl;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/images/breakfast.png',
      titleTxt: 'Kahvaltı',
      kacl: 525,
      meals: <String>['Ekmek,', 'Reçel,', 'Elma'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/images/lunch.png',
      titleTxt: 'Öğle Yemeği',
      kacl: 602,
      meals: <String>['Salata,', 'Ekmek,', 'Portakal'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/images/snack.png',
      titleTxt: 'Atıştırma',
      kacl: 0,
      meals: <String>['Gereken:', '800 kcal'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/images/dinner.png',
      titleTxt: 'Akşam Yemeği',
      kacl: 0,
      meals: <String>['Gereken:', '703 kcal'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
