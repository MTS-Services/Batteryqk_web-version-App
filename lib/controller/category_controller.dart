import 'package:get/get.dart';
import 'package:batteryqk_web/data/service/category_service.dart';
import '../data/model/catagory_create_model.dart';


class CategoryController extends GetxController {


  var isLoading = false.obs;
  var success = false.obs;

  Future<bool> createCategory(CategoryCreateModel model) async {
    isLoading.value = true;
    success.value = false;

    final result = await CategoryCreateService.createCategory(model);


    success.value = result;
    isLoading.value = false;
    return true;
  }
}
