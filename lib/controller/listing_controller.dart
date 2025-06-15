// import 'package:get/get.dart';
// import '../data/model/listing_data_model.dart';
// import '../data/service/listing_service.dart';
//
// class ListingController extends GetxController {
//   var isLoading = false.obs;
//
//   Future<void> createListing(ListingData listingData) async {
//     try {
//       isLoading.value = true;
//       await ListingService.createListing(listingData, listingData: null, mainImageFile: null);
//     } catch (e) {
//       print("Controller Error: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
