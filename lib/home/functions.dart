import 'dart:async';

import 'package:coop_location/home/controller.dart';
import 'package:coop_location/home/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:location/location.dart' as loc;
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'alert_dialog_option_select.dart';

Widget? getSuffixWidget({required String title}) {
  Widget? suffixWidget;
  if (['Type', 'District', 'Region'].contains(title)) {
    suffixWidget = Padding(
      padding: const EdgeInsets.only(right: 8, left: 5),
      child: const Icon(
        Icons.arrow_drop_down_rounded,
        color: Colors.teal,
        size: 24,
      ),
    );
  }
  return suffixWidget;
}

Icon? titleToIcon({
  required String title,
}) {
  IconData? iconData;
  if (['City', 'Region', 'Street'].contains(title)) {
    iconData = Icons.location_on_outlined;
  } else if (title == 'District') {
    iconData = Icons.corporate_fare_rounded;
  } else if (title == 'Phone number') {
    iconData = Icons.phone;
  } else if (title == 'Branch name') {
    iconData = Icons.account_balance_outlined;
  } else if (title == 'Branch code') {
    iconData = Icons.key_outlined;
  } else if (title == 'Type') {
    iconData = Icons.filter_alt_outlined;
  }
  return iconData != null
      ? Icon(
          iconData,
          size: 24,
          color: Colors.grey.shade700,
        )
      : null;
}

String? titleToHelperText({
  required String title,
}) {
  String? helperText;

  if (title == 'City') {
    helperText = 'eg. Jima, Ambo, Lemi kura';
  } else if (title == 'Street') {
    helperText = 'eg. Woreda 08 around Gast mall';
  }else if (title == 'Branch code') {
    helperText = 'eg. ET000000';
  }
  return helperText;
}

onTextFieldPressed({required String title, int? index}) {
  List<String> data = [];
  if (['District', 'Type', 'Region'].contains(title)) {
    if (title == 'District') {
      data = [
        'East Finfinne',
        'West Finfinne',
        'North Finfinne',
        'South FInfinne',
        'Central Finfinne',
        'Jima',
        'Chiro',
        'Dire Dawa',
        'Asella',
        'Hosana',
        'Hawassa',
        'Bale',
        'Nekemt',
        'Mekele RO',
        'Bahirdar RO',
        'Adama',
        'Shashemene',
      ].reversed.toList();
    } else if (title == 'Type') {
      data = ['CRM', 'NCR', 'Branch'].reversed.toList();
    } else {
      data = [
        'Addis Ababa',
        'Afar',
        'Amhara',
        'Benishangul-Gumuz',
        'Central Ethiopia Regional State',
        'Dire Dawa',
        'Gambella',
        'Harari',
        'Oromia',
        'Sidama',
        'Somali',
        'South Ethiopia Regional State',
        'South West Ethiopian Peoples',
        'Tigray'
      ].reversed.toList();
    }
    Get.dialog(AlertDialogOptionSelect(
      title: title,
      data: data,
    )).then((value) => unFocus());
  }
}

onAlertDialogOptionSelect(
    {required String title, required int index, required String data}) {
  Controller controller = Controller.to;
  if (title == 'Type') {
    controller.type = data;
  } else if (title == 'District') {
    controller.district = data;
  } else if (title == 'Region') {
    controller.region = data;
  }
  controller.update();
  Get.back();
}

unFocus() => FocusManager.instance.primaryFocus?.unfocus();

void executeAfterBuild(VoidCallback function) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    function();
  });
}

bool isReadOnlyTitle({String? title}) {
  return ['Type', 'District', 'Region'].contains(title);
}

String? titleToData({required String title, int? index}) {
  Controller controller = Controller.to;
  if (title == 'Type') {
    return controller.type;
  } else if (title == 'District') {
    return controller.district;
  } else if (title == 'Branch name') {
    return controller.branch;
  } else if (title == 'Branch code') {
    return controller.branchCode;
  } else if (title == 'Phone number') {
    return controller.phoneNumber;
  } else if (title == 'Region') {
    return controller.region;
  } else if (title == 'City') {
    return controller.city;
  } else if (title == 'Street') {
    return controller.street;
  }
  return null;
}

onTextFieldChange({
  String? title,
  required String data,
  int? index,
}) {
  Controller controller = Controller.to;
  if (title == 'Branch name') {
    controller.branch = data;
  }
  if (title == 'Branch code') {
    controller.branchCode = data;
  } else if (title == 'Phone number') {
    controller.phoneNumber = data;
  } else if (title == 'Region') {
    controller.region = data;
  } else if (title == 'City') {
    controller.city = data;
  } else if (title == 'Street') {
    controller.street = data;
  }
}

onActionButtonPressed() async {
  unFocus();
  Controller controller = Controller.to;
  controller.isSubmitButtonPressed = true;
  controller.update();
  if (controller.formKey.currentState!.validate()) {
    if (Controller.to.latitude == 0 || Controller.to.longitude == 0) {
      Get.snackbar(
          'Error', 'Location is not selected. Please press Get location first',
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(.8),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15));
    } else {
      Controller controller = Controller.to;
      controller.isSubmitting = true;
      controller.update();
      try {
        // await Future.delayed(Duration(seconds: 3));
        // Get.snackbar('succes', 'message cdcvnhdsjvb dsbvsd',
        //     snackPosition: SnackPosition.BOTTOM,
        //     backgroundColor: Colors.green.withOpacity(.5),
        //     margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15));

        final backupData = ParseObject('LocationData')
          ..set('BranchCode', controller.branchCode)
          ..set('BranchName', controller.branch)
          ..set('Type', controller.type)
          ..set('Region',
              '${controller.street},${controller.city},${controller.region}')
          ..set('PhoneNumber',
              controller.type == 'Branch' ? controller.phoneNumber : '609')
          ..set('Latitude', controller.latitude)
          ..set('Longitude', controller.longitude)
          ..set('District', controller.district);
        var backupResult = await backupData.save();
        if (backupResult.statusCode == 201 || backupResult.statusCode == 200) {
          Get.off(SuccessScreen());
        } else {
          Get.snackbar(
            'Error',
            'Connection problem. Please check your connection and retry',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15)
          );

          return null;
        }
      } catch (e) {
        Get.snackbar(
            'Error',
            'Connection problem. Please check your connection and retry',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15)
        );
      } finally {
        controller.isSubmitting = false;
        controller.update();
      }
    }
  }
}

Future<bool> _handleLocationPermission() async {
  bool _serviceEnabled;
  loc.Location location = loc.Location();
  LocationPermission permission;
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      Controller controller = Controller.to;
      controller.isLocationLoading = false;
      controller.update();
      return false;
    }
  }
  permission = await Geolocator.checkPermission();
  // permission = await location.;
  if ( permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
    Controller controller = Controller.to;
    controller.isLocationLoading = false;
    controller.update();
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          duration: Duration(seconds: 8),
          content: Text(
              'Location permissions are denied. Please allow permission to enable us to get your current location')));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    Controller controller = Controller.to;
    controller.isLocationLoading = true;
    controller.update();
    ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        duration: Duration(seconds: 5),
        content: Text(
            'Location permissions are permanently denied, we cannot request permissions.')));
    return false;
  }
  return true;
}

Future<void> getCurrentPosition() async {
  final hasPermission = await _handleLocationPermission();
  // if (!hasPermission)
  //   return;
  if (hasPermission) {
    Controller controller = Controller.to;
    controller.isLocationLoading = true;
    controller.locationError = false;
    controller.update();
    Geolocator.getPositionStream(
            locationSettings: LocationSettings(accuracy: LocationAccuracy.high,timeLimit: Duration(seconds: 15)))
        .listen((Position? position) {
      controller.latitude = position?.latitude ?? 0;
      controller.longitude = position?.longitude ?? 0;
      controller.isLocationLoading = false;
      controller.update();
    }, onError: (_) {
      controller.isLocationLoading = false;
      controller.locationError = true;
      controller.update();
    });
    // await Geolocator.getCurrentPosition(
    //         desiredAccuracy: LocationAccuracy.high,
    //         timeLimit: Duration(seconds: 10))
    //     .then((Position position) {
    //   controller.latitude = position.latitude;
    //   controller.longitude = position.longitude;
    //   controller.isLocationLoading = false;
    //   controller.update();
    //   // setState(() => _currentPosition = position);
    // }).catchError((e) {
    //   controller.isLocationLoading = false;
    //   controller.locationError = true;
    //   controller.update();
    // });
  }else{
    Controller controller = Controller.to;
    controller.isLocationLoading = false;
    controller.update();
  }
}

validateInput({
  required String title,
  required String data,
}) {
  if (title != 'Phone number' && data.trim().isEmpty) {
    return 'Required field';
  }

  return null;
}
