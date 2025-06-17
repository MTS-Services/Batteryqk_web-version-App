import 'package:batteryqk_web/data/model/sub_category_model.dart';

class CategoryCreateModel {
  final String mainCategory;
  final List<SubCategory> subCategories;

  CategoryCreateModel({
    required this.mainCategory,
    required this.subCategories,
  });

  factory CategoryCreateModel.fromJson(Map<String, dynamic> json) {
    return CategoryCreateModel(
      mainCategory: json['mainCategory'],
      subCategories: (json['subCategories'] as List)
          .map((e) => SubCategory.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mainCategory': mainCategory,
      'subCategories': subCategories.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'CategoryCreateModel{mainCategory: $mainCategory, subCategories: $subCategories}';
  }
}
