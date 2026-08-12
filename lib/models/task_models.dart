class TaskModels {
  final int id;
  final String title;
  final String description;
  bool isdone;

  TaskModels({
    required this.id,
    required this.title,
    required this.description,
    required this.isdone,
  });

  factory TaskModels.fromJson(Map<String, dynamic> json) {
    return TaskModels(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isdone: json['isdone'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'isdone': isdone,
  };
}
