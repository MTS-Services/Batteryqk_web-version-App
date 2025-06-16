import 'dart:convert';
import 'package:batteryqk_web/data/model/item_model.dart';
import 'package:batteryqk_web/data/utils/urls.dart';
import 'package:batteryqk_web/screen/widget/show_Snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/catagory_create_model.dart';

class CategoryCreateService {
 static Future<bool> createCategory(CategoryCreateModel createCategory) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
       print(token);
      if (token == null || token.isEmpty) {
        showSnackbar("Unauthorized", "User token missing");
        print("Token not found");
        return false;
      }

      final String categoryUrl =  Urls.categoryCreate;

       final url =  Uri.parse(categoryUrl);

       print(url);

       var bodyJsonData =  jsonEncode(createCategory.toMap());

       print("bodydata: $bodyJsonData");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body:bodyJsonData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showSnackbar("Success", "Category Created Successfully");
        print("Category Created: ${response.body}");
        return true;
      } else {
        print("Failed to create category. Status: ${response.statusCode}");
        print("Response Body: ${response.body}");
        showSnackbar("Error", "Failed to create category");
        return false;
      }
    } catch (e, s) {
      print("Error while creating category: e=>$e, s=>$s");
      showSnackbar("Error", "Something went wrong");
      return false;
    }
  }

 static Future<List<ItemModel>> getItemList() async {
    try {

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        showSnackbar("Unauthorized", "User token missing");
        print("Token not found");
        return [];
      }

      final Uri url = Uri.parse(Urls.getItem);


      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final items = jsonList.map((item) => ItemModel.fromJson(item)).toList();
        print("items===>$items");
        return items;
      } else {
        throw Exception("Failed to load items: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception('Error fetching items: $e');
    }
  }
}
