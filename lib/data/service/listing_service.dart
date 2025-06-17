import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:batteryqk_web/data/model/listing_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:batteryqk_web/data/model/listing_response_model.dart';
import 'package:batteryqk_web/data/utils/urls.dart';
import 'dart:html' as html;
import 'package:shared_preferences/shared_preferences.dart';

import '../../screen/widget/show_Snackbar.dart';
import '../model/item_listing.dart';

class ListingService {
  static Future<ListingResponseModel?> createListing({
    required Map<String, String> fields,
    required dynamic mainImage,
    required List<dynamic> subImages,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final url = Uri.parse(Urls.listingCreate);
    final request = http.MultipartRequest("POST", url);
    request.headers['Authorization'] = 'Bearer $token';
    request.fields.addAll(fields);

    Future<Uint8List?> readFile(html.File file) async {
      final reader = html.FileReader();
      final completer = Completer<Uint8List>();

      reader.readAsArrayBuffer(file);
      reader.onLoad.listen((event) {
        completer.complete(reader.result as Uint8List);
      });
      reader.onError.listen((event) {
        completer.completeError("Error reading file");
      });

      return completer.future;
    }

    if (kIsWeb) {
      try {
        final mainImageData = await readFile(mainImage);
        if (mainImageData == null) return null;

        String mainImageName = mainImage.name ?? "default_name.jpg";
        if (mainImageName == "unnamed.jpg") {
          mainImageName = "default_name.jpg";
        }

        request.files.add(http.MultipartFile.fromBytes(
          'main_image',
          mainImageData,
          filename: mainImageName,
        ));

        for (html.File image in subImages) {
          final subImageData = await readFile(image);
          if (subImageData == null) continue;

          String subImageName = image.name ?? "default_sub_image.jpg";
          if (subImageName == "unnamed.jpg") {
            subImageName = "default_sub_image.jpg";
          }

          request.files.add(http.MultipartFile.fromBytes(
            'sub_images',
            subImageData,
            filename: subImageName,
          ));
        }
      } catch (e) {
        return null;
      }
    } else {
      try {
        final io.File main = mainImage as io.File;

        if (main.path.isEmpty) {
          return null;
        }

        final fileSize = await main.length();
        if (fileSize > 2.5 * 1024 * 1024) {
          return null;
        }

        request.files.add(await http.MultipartFile.fromPath(
          'main_image',
          main.path,
        ));

        for (io.File image in subImages) {
          if (image.path.isEmpty) {
            continue;
          }

          final subFileSize = await image.length();
          if (subFileSize > 2.5 * 1024 * 1024) {
            continue;
          }

          request.files.add(await http.MultipartFile.fromPath(
            'sub_images',
            image.path,
          ));
        }
      } catch (e) {
        return null;
      }
    }

    try {
      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      if (streamedResponse.statusCode == 200 || streamedResponse.statusCode == 201) {
        final decodedJson = jsonDecode(responseBody);
        return ListingResponseModel.fromJson(decodedJson);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  static Future<List<ItemListing>> fetchListing() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final url = Uri.parse(Urls.getListing);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final List<dynamic> listingData = responseBody['data']['listings'];

        if (listingData.isEmpty) {
          print("No listings available.");
          return [];
        }

        List<ItemListing> itemList = listingData.map((e) {
          print("Mapping item: $e");
          return ItemListing.fromJson(e);
        }).toList();

        showSnackbar("Success", "Listings fetched successfully");

        return itemList;
      } else {
        print("Failed to load listings. Status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error occurred: $e");
      return [];
    }
  }



}
