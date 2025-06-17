import 'item_listing.dart';

class ListingDataModel {
  final bool success;
  final String message;
  final ItemListing listing;

  ListingDataModel({
    required this.success,
    required this.message,
    required this.listing,
  });

  factory ListingDataModel.fromJson(Map<String, dynamic> json) {
    return ListingDataModel(
      success: json['success'],
      message: json['message'],
      listing: ItemListing.fromJson(json['listing']),
    );
  }


  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'listing': listing.toJson(),
  };

  @override
  String toString() {
    return 'ListingDataModel{success: $success, message: $message, listing: $listing}';
  }
}
