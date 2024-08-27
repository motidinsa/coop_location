import 'package:coop_location/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:location/location.dart' as loc;
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'alert_dialog_option_select.dart';

Widget? getSuffixWidget({required String title}) {
  Widget? suffixWidget;
  if (['Type', 'District'].contains(title)) {
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
  }else if (title == 'Branch name') {
    iconData = Icons.account_balance_outlined;
  }else if (title == 'Branch code') {
    iconData = Icons.key_outlined;
  }else if (title == 'Type') {
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

onTextFieldPressed(
    {required String title, int? index, required BuildContext context}) {
  List<String> data = [];
  if (['District', 'Type'].contains(title)) {
    if (title == 'District') {
      data = ['Dis A', 'Dis B', 'Dis c'];
    } else {
      data = ['CRM', 'NCR', 'Branch'];
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
  return ['Type', 'District'].contains(title);
}

String? titleToData({required String title, int? index}) {
  Controller controller = Controller.to;
  if (title == 'Type') {
    return controller.type;
  } else if (title == 'District') {
    return controller.district;
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
  Controller controller = Controller.to;
  controller.isSubmitting = true;
  controller.update();
  try {
    // await Future.delayed(Duration(seconds: 1));
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
      ..set('PhoneNumber', controller.phoneNumber)
      ..set('Latitude', controller.latitude)
      ..set('Longitude', controller.longitude)
      ..set('District', controller.district);
    var backupResult = await backupData.save();
    if (backupResult.statusCode == 201 || backupResult.statusCode == 200) {
      Get.snackbar('succes', 'message cdcvnhdsjvb dsbvsd',snackPosition: SnackPosition.BOTTOM);
    } else {
      // showSnackbar(
      //   text:
      //   'error uploading other transaction number\n${otherTransactionNumberResult
      //       .error?.message}',
      //   hideBeforeSnackBar: true,
      // );
      return null;
    }
  } catch (e) {
  } finally {
    controller.isSubmitting = false;
    controller.update();
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
      debugPrint('Location Denied once');
    }
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    // if (permission == LocationPermission.denied) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Location permissions are denied')));
    //   return false;
    // }
  }
  if (permission == LocationPermission.deniedForever) {
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text(
    //         'Location permissions are permanently denied, we cannot request permissions.')));
    // return false;
  }
  return true;
}

Future<void> getCurrentPosition() async {
  Controller controller = Controller.to;
  controller.isLocationLoading = true;
  controller.locationError = false;
  controller.update();
  final hasPermission = await _handleLocationPermission();
  if (!hasPermission)
    return;
  else {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      controller.latitude = position.latitude;
      controller.longitude = position.longitude;
      controller.isLocationLoading = false;
      controller.update();
      // setState(() => _currentPosition = position);
    }).catchError((e) {
      controller.isLocationLoading = false;
      controller.locationError = true;
      controller.update();
    });
  }
}

Future<bool?> uploadToDatabaseBack4App() async {
  Controller controller = Controller.to;
  final backupData = ParseObject('LocationData')
    ..set('BranchCode', 'et33')
    ..set('BranchName', controller.branch)
    ..set('Type', controller.type)
    ..set('Region',
        '${controller.street},${controller.city},${controller.region}')
    ..set('PhoneNumber', controller.phoneNumber)
    ..set('Latitude', controller.latitude)
    ..set('Longitude', controller.longitude)
    ..set('District', controller.district);
  var backupResult = await backupData.save();
  if (backupResult.statusCode == 201 || backupResult.statusCode == 200) {
  } else {
    // showSnackbar(
    //   text:
    //   'error uploading other transaction number\n${otherTransactionNumberResult
    //       .error?.message}',
    //   hideBeforeSnackBar: true,
    // );
    return null;
  }
}
