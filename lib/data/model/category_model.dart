class CategoryModel {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? mainCategoryId;

  CategoryModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.mainCategoryId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      mainCategoryId: json['mainCategoryId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    if (mainCategoryId != null) 'mainCategoryId': mainCategoryId,
  };

  @override
  String toString() {
    return 'CategoryModel{id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, mainCategoryId: $mainCategoryId}';
  }
}
