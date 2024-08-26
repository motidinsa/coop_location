import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertDialogOptionSelect extends StatelessWidget {
  final String title;
  final List<String> data;

  const AlertDialogOptionSelect({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 15,
          bottom:
              // title != selectSourceN && !isAlertDialogListEmpty(title: title)
              //     ?
              15
                  // : 0
          ,
        ),
        shape:SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(cornerRadius: 15),
          side: BorderSide.none,
        ),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        content: SizedBox(
          width:  double.maxFinite ,
          child: ListView(
                  shrinkWrap: true,
                  physics:const ClampingScrollPhysics(),
                  children: [
                     ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return AlertDialogOptionItem(
                                  title: title,
                                  listIndex: [
                                    RouteName.addPurchase,
                                    RouteName.addSales
                                  ].contains(Get.currentRoute)
                                      ? listIndex
                                      : null,
                                  index: index);
                            },
                            itemCount: data.length,
                          ),
                    const SizedBox(height: 8)
                  ],
                ),
        ),
      ),
    );
  }
}
