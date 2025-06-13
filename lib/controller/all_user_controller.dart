import 'package:get/get.dart';
import '../data/model/user_model.dart';
import '../data/service/get_all_user_service.dart';

class AllUserController extends GetxController {
  var userList = <UserModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllUsers();
  }

  void fetchAllUsers() async {
    try {
      isLoading(true);
      final users = await UserService.fetchAllUsers();
      userList.assignAll(users);
      print("Loaded users: $userList");
    } catch (e) {
      print("Error fetching users: $e");
    } finally {
      isLoading(false);
    }
  }
}

