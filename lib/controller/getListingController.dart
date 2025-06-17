import 'package:get/get.dart';

import '../data/model/item_listing.dart';
import '../data/service/listing_service.dart';
import '../screen/widget/show_Snackbar.dart';

class GetListingController extends GetxController {
  var isLoading = true.obs;
  var itemList = <ItemListing>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      isLoading(true);
      final items = await ListingService.fetchListing();
      print("Fetched items: $items");
      itemList.assignAll(items);
      // print("Itemlist ==== ${itemList.toString()}");

    } catch (e) {
      // showSnackbar("Failed", "Listing creation failed");
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
