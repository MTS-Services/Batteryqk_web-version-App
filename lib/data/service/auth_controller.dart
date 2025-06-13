import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../screen/widget/show_Snackbar.dart';
import '../model/logi_in_model.dart';
import '../utils/urls.dart';

class ApiService {
  static Future<void> userLogIn(UserLogin userLogin) async {
    final String url = Urls.userLogin;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userLogin.toJson()),
      );

      print("Request URL: $url");
      print("Request Body: ${jsonEncode(userLogin.toJson())}");
      print("Response statusCode: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {

        final Map<String , dynamic> responseData = jsonDecode(response.body);

        final String token = responseData['token'];

        final saveToken = await SharedPreferences.getInstance();
        saveToken.setString("token", token);

        print("Token ======> $token");

        showSnackbar("Success", "Login successful");
        Get.toNamed('/Responsive');
      } else {
        showSnackbar("Failed", "Login failed: ${response.statusCode}");
        print("Unexpected status code: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      showSnackbar("Error", "An error occurred: $e");
      print("Exception occurred: $e");
      print("Stack Trace: $stackTrace");
    }
  }
}
