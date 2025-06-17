import 'package:batteryqk_web/data/model/specific_item_model.dart';
import 'category_model.dart';

class ItemListing {
  final int id;
  final String name;
  final String price;
  final String? mainImage;
  final List<String> subImages;
  final List<String> agegroup;
  final List<String> location;
  final List<String> facilities;
  final List<String> operatingHours;
  final bool isActive;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CategoryModel> selectedMainCategories;
  final List<CategoryModel> selectedSubCategories;
  final List<SpecificItem> selectedSpecificItems;

  ItemListing({
    required this.id,
    required this.name,
    required this.price,
    this.mainImage,
    required this.subImages,
    required this.agegroup,
    required this.location,
    required this.facilities,
    required this.operatingHours,
    required this.isActive,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.selectedMainCategories,
    required this.selectedSubCategories,
    required this.selectedSpecificItems,
  });

  factory ItemListing.fromJson(Map<String, dynamic> json) {
    return ItemListing(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      mainImage: json['main_image'],
      subImages: List<String>.from(json['sub_images']),
      agegroup: List<String>.from(json['agegroup']),
      location: List<String>.from(json['location']),
      facilities: List<String>.from(json['facilities']),
      operatingHours: List<String>.from(json['operatingHours']),
      isActive: json['isActive'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      selectedMainCategories:
          (json['selectedMainCategories'] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList(),
      selectedSubCategories:
          (json['selectedSubCategories'] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList(),
      selectedSpecificItems:
          (json['selectedSpecificItems'] as List)
              .map((e) => SpecificItem.fromJson(e))
              .toList(),
    );
  }



  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'main_image': mainImage,
    'sub_images': subImages,
    'agegroup': agegroup,
    'location': location,
    'facilities': facilities,
    'operatingHours': operatingHours,
    'isActive': isActive,
    'description': description,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'selectedMainCategories':
        selectedMainCategories.map((e) => e.toJson()).toList(),
    'selectedSubCategories':
        selectedSubCategories.map((e) => e.toJson()).toList(),
    'selectedSpecificItems':
        selectedSpecificItems.map((e) => e.toJson()).toList(),
  };

  @override
  String toString() {
    return 'ItemListing{id: $id, name: $name, price: $price, mainImage: $mainImage, subImages: $subImages, agegroup: $agegroup, location: $location, facilities: $facilities, operatingHours: $operatingHours, isActive: $isActive, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, selectedMainCategories: $selectedMainCategories, selectedSubCategories: $selectedSubCategories, selectedSpecificItems: $selectedSpecificItems}';
  }
}
