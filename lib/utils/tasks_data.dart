class Task {
  Task({
    required this.title,
    required this.goal,
    this.isCompleted = false,
  });

  String title;
  String goal;
  bool isCompleted;

  static List<Task> tasks = [
    Task(title: "Günlük kalori alımı", goal: "2344 kcal"),
    Task(title: "Yakılan kalori", goal: "250 kcal", isCompleted: true),
    Task(title: "Günlük su tüketimi", goal: "3.5 litre"),
    Task(title: "Günlük adım sayısı", goal: "10.000 adım"),
    //Task(title: "Günlük uyku süresi", goal: "8 saat", isCompleted: true),
  ];
}
