import 'package:flutter/material.dart';

import 'functions.dart';

class AlertDialogOptionItem extends StatelessWidget {
  final String title;
  final String data;
  final int index;

  const AlertDialogOptionItem({
    super.key,
    required this.title,
    required this.index,required this.data
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          data,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
        ),
      ),
      titleAlignment: ListTileTitleAlignment.center,
      onTap: () => onAlertDialogOptionSelect(
          title: title,  index: index,data: data),
    );
  }
}
