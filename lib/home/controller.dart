import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Controller extends GetxController {
  String type = '';
  String district = '';
  String city = '';
  String town = '';
  String latitude = '';
  String longitude = '';

  static Controller get to => Get.find();

  @override
  Future<void> onInit() async {
    super.onInit();

  }
}
