import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(String title, String message, {Color? backgroundColor}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backgroundColor ?? Colors.blue,
    colorText: Colors.white,
    margin: const EdgeInsets.all(12),
    borderRadius: 8,
    icon: const Icon(Icons.info, color: Colors.white),
    duration: const Duration(seconds: 3),
  );
}
