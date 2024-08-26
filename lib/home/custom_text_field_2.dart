import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'functions.dart';

class CustomTextField2 extends StatefulWidget {
  final String title;
  final Color? color;
  final int? index;

  const CustomTextField2(
      {super.key, required this.title, this.color, this.index});

  @override
  State<CustomTextField2> createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    executeAfterBuild(() {
      textEditingController.value = textEditingController.value.copyWith(
        text: titleToData(
          title: widget.title,
          index: widget.index,
        ),
      );
    });
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      controller: textEditingController,
      focusNode: focusNode,
      maxLines: widget.title == descriptionN ? 2 : 1,
      readOnly: isReadOnlyTitle(title: widget.title),
      onChanged: (data) => onTextFieldChange(
        title: widget.title,
        index: widget.index,
        data: data,
      ),
      onTap: () => onTextFieldPressed(
        title: widget.title,
        index: widget.index,
      ),
      decoration: InputDecoration(
          fillColor: widget.color ?? Colors.green.shade50,
          filled: true,
          errorMaxLines: 2,
          border: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12)),
          prefixIcon: titleToIcon(title: widget.title),
          suffixIcon: getSuffixWidget(title: widget.title),
          suffixIconConstraints: BoxConstraints(),
          labelText: widget.title,
          // labelStyle: TextStyle(overflow: TextOverflow.fade),
          floatingLabelStyle: TextStyle(color: Colors.green.shade900),
          contentPadding:   const EdgeInsets.only(left: 30, right: 20, top: 10, bottom: 10),
      // validator: (value) => validateInput(
      //   data: textEditingController.text,
      //   title: widget.title,
      // ),
    );
  }
}
