import 'package:batteryqk_web/data/model/listing_data_model.dart';

class ListingResponseModel {
  final bool success;
  final String message;
  final ListingDataModel data;

  ListingResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ListingResponseModel.fromJson(Map<String, dynamic> json) {
    return ListingResponseModel(
      success: json['success'],
      message: json['message'],
      data: ListingDataModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.toJson(),
  };
}
