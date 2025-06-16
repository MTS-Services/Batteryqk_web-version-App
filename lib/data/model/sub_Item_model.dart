import 'package:batteryqk_web/data/model/spacific_Item_model.dart';

class SubItemModel {
  final String name;
  final int id;
  final List<SpecificItemModel> specificItems;

  SubItemModel({
    required this.name,
    required this.id,
    required this.specificItems,
  });

  factory SubItemModel.fromJson(Map<String, dynamic> json) {
    return SubItemModel(
      name: json['name'],
      id: json['id'],
      specificItems: (json['specificItems'] as List)
          .map((e) => SpecificItemModel.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'SubItemModel(name: $name, id: $id, specificItems: $specificItems)';
  }
}
