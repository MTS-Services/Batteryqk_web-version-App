class MainItemModel {
  final String name;
  final int id;

  MainItemModel({
    required this.name,
    required this.id,
  });

  factory MainItemModel.fromJson(Map<String, dynamic> json) {
    return MainItemModel(
      name: json['name'],
      id: json['id'],
    );
  }

  @override
  String toString() {
    return 'MainItemModel(name: $name, id: $id)';
  }
}
