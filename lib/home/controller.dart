import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'functions.dart';

class Controller extends GetxController {
  String type = '';
  String district = '';
  String branch = '';
  String branchCode = '';
  String phoneNumber = '';
  String region = '';
  String city = '';
  String street = '';
  double latitude = 0;
  double longitude = 0;
  bool isLocationLoading = false;
  bool locationError = false;
  bool isSubmitting = false;
  bool isSubmitButtonPressed = false;
  List<String> titles = [
    'Type',
    'District',
    'Branch name',
    'Branch code',
    'Phone number',
    'Region',
    'City',
    'Street'
  ];
  final formKey = GlobalKey<FormState>();

  static Controller get to => Get.find();

  @override
  Future<void> onInit() async {

    super.onInit();
  }
}
