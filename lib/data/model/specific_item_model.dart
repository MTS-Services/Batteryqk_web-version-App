class SpecificItem {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int subCategoryId;
  final int mainCategoryId;

  SpecificItem({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.subCategoryId,
    required this.mainCategoryId,
  });

  factory SpecificItem.fromJson(Map<String, dynamic> json) {
    return SpecificItem(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      subCategoryId: json['subCategoryId'],
      mainCategoryId: json['mainCategoryId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'subCategoryId': subCategoryId,
    'mainCategoryId': mainCategoryId,
  };

  @override
  String toString() {
    return 'SpecificItem{id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, subCategoryId: $subCategoryId, mainCategoryId: $mainCategoryId}';
  }
}
