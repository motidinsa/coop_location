import 'package:coop_location/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'alert_dialog_option_select.dart';

Widget? getSuffixWidget({required String title}) {
  Widget? suffixWidget;
  if (['Type','District'].contains(title)) {
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
  if ( ['City','Town'].contains(title)) {
    iconData = Icons.location_on_outlined;
  } else if (title == 'District') {
    iconData = Icons.corporate_fare_rounded;
  }
  return iconData != null
      ? Icon(
    iconData,
    size: 24,
    color: Colors.grey.shade700,
  )
      : null;
}

onTextFieldPressed({required String title, int? index}) {
  List<String> data = [];
  if(['District','Type'].contains(title)){
    if (title == 'District') {
      data = ['Dis A', 'Dis B','Dis c'];

    }else{
      data = ['CRM', 'NCR','Branch'];
    }
  };

  Get.dialog(AlertDialogOptionSelect(
      title: title,data: data,
  ));
}
onAlertDialogOptionSelect(
    {required String title, required int index, }) {
  Controller controller = Controller.to;
  if (title == 'Type') {
    controller.type = title;
  }
  controller.update();
  Get.back();
}