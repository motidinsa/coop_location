import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'alert_dialog_option_item.dart';

class AlertDialogOptionSelect extends StatelessWidget {
  final String title;
  final List<String> data;

  const AlertDialogOptionSelect(
      {super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        // surfaceTintColor: Color(0xff00AEEF),
        // surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 15,
          bottom: 15
          // : 0
          ,
        ),
        shape: SmoothRectangleBorder(
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
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ListView.builder(
                shrinkWrap: true,
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return AlertDialogOptionItem(
                    title: title,
                    index: index,
                    data: data[index],
                  );
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
