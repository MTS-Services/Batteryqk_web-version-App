import 'package:get/get.dart';
import 'package:batteryqk_web/data/service/category_create_service.dart';
import '../data/model/catagory_create_model.dart';


class CategoryController extends GetxController {
  final CategoryCreateService _service = CategoryCreateService();

  var isLoading = false.obs;
  var success = false.obs;

  Future<bool> createCategory(CategoryCreateModel model) async {
    isLoading.value = true;
    success.value = false;

    final result = await _service.createCategory(model);


    success.value = result;
    isLoading.value = false;
    return true;
  }
}
