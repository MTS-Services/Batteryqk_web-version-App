import 'package:batteryqk_web/data/model/item_model.dart';
import 'package:batteryqk_web/data/service/category_service.dart';
import 'package:get/get.dart';

class ItemController extends GetxController {
  var isLoading = false.obs;
  var itemList = <ItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

   fetchItems() async {
    try {
      isLoading(true);
      final items = await CategoryCreateService.getItemList();
      itemList.assignAll(items);

    } catch (e) {

    } finally {
      isLoading(false);
    }
  }
}
