import 'dart:io' as io;
import 'package:batteryqk_web/data/model/listing_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../data/model/listing_response_model.dart';
import '../data/service/listing_service.dart';
import '../screen/widget/show_Snackbar.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class ListingController extends GetxController {
  var isLoading = false.obs;
  var responseData = Rxn<ListingResponseModel>();
  Future<void> createListing({
    required Map<String, String> fields,
    required dynamic mainImage,
    required List<dynamic> subImages,
  }) async {
    try {
      isLoading.value = true;

      if (kIsWeb && (mainImage is! html.File || subImages.any((e) => e is! html.File))) {
        throw Exception("Web platform requires html.File type");
      }

      if (!kIsWeb && (mainImage is! io.File || subImages.any((e) => e is! io.File))) {
        throw Exception("Mobile platform requires dart:io File type");
      }

      final response = await ListingService.createListing(
        fields: fields,
        mainImage: mainImage,
        subImages: subImages,
      );

      if (response != null) {
        responseData.value = response;
        showSnackbar("Success", response.message);
      } else {
        showSnackbar("Failed", "Listing creation failed");
      }
    } catch (e) {
      print("Controller Exception: $e");
      showSnackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

}
