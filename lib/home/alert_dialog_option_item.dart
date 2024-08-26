import 'package:flutter/material.dart';

class AlertDialogOptionItem extends StatelessWidget {
  final String title;
  final int index;
  final int? listIndex;

  const AlertDialogOptionItem({
    super.key,
    required this.title,
    required this.index,
    this.listIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
        ),
      ),
      titleAlignment: ListTileTitleAlignment.center,
      onTap: () => onAlertDialogOptionSelect(
          title: title, listIndex: listIndex, index: index),
    );
  }
}
