class SubCategory {
  final String name;
  final List<String> specificItems;

  SubCategory({
    required this.name,
    required this.specificItems,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      name: json['name'],
      specificItems: List<String>.from(json['specificItems']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'specificItems': specificItems,
    };
  }

  @override
  String toString() {
    return 'SubCategory{name: $name, specificItems: $specificItems}';
  }
}
