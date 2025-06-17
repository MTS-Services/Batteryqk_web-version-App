import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/updateModel.dart';
import '../model/user_model.dart';
import '../utils/urls.dart';

class UserService {
  static Future<List<UserModel>> fetchAllUsers() async {
    final String url = Urls.getAllUser;

    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      throw Exception("No token found. Please login first.");
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {

      throw Exception("Status Code: ${response.statusCode}");
    }
  }

  static Future<bool> deleteUser(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) throw Exception("No Auth token");

    final url = "${Urls.userDelete}/$id";

    // print("DELETE URL: $url");

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // print("Status Code: ${response.statusCode}");
    // print("Response Body: ${response.body}");

    return response.statusCode == 200 || response.statusCode == 204;
  }

 static Future<bool> userUpdate(int id , UpdateModel updateModel) async{
    final  saveToken = await SharedPreferences.getInstance();
    final String? token = saveToken.getString('token');
   if(token == null) throw Exception("No auth token");
   final url = "${Urls.userUpdate}/$id";

   // print("Update Url : $url");

   final response = await http.put(
     Uri.parse(url),
     headers: {
       'Content-Type' : 'application/json',
       'Authorization' : "Bearer $token"
     },
     body: jsonEncode(updateModel.toJson())
   );
    // print("Status Code: ${response.statusCode}");
    // print("Response Body: ${response.body}");

    return response.statusCode == 200 || response.statusCode == 201;
 }
}
