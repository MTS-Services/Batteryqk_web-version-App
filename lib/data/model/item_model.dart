import 'main_Item_model.dart';
import 'sub_Item_model.dart';

class ItemModel {
  final MainItemModel mainCategory;
  final List<SubItemModel> subCategories;
  final DateTime createdAt;
  final DateTime updatedAt;

  ItemModel({
    required this.mainCategory,
    required this.subCategories,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      mainCategory: MainItemModel.fromJson(json['mainCategory']),
      subCategories: (json['subCategories'] as List)
          .map((e) => SubItemModel.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  String toString() {
    return 'ItemModel(mainCategory: $mainCategory, subCategories: $subCategories, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
