class SpecificItemModel {
  final String name;
  final int id;

  SpecificItemModel({
    required this.name,
    required this.id,
  });

  factory SpecificItemModel.fromJson(Map<String, dynamic> json) {
    return SpecificItemModel(
      name: json['name'],
      id: json['id'],
    );
  }

  @override
  String toString() {
    return 'SpecificItemModel(name: $name, id: $id)';
  }
}
