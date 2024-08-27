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
        readOnly: isReadOnlyTitle(title: widget.title),
        keyboardType: widget.title == 'Phone number'?TextInputType.phone:null,
        onChanged: (data) => onTextFieldChange(
              title: widget.title,
              data: data,
            ),
        onTap: () => onTextFieldPressed(
              title: widget.title,
              index: widget.index,context: context
            ),
        decoration: InputDecoration(
          fillColor: widget.color ?? Color(0xff00AEEF).withOpacity(.1),
          filled: true,
          errorMaxLines: 2,
          border: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12)),
          prefixIcon: titleToIcon(title: widget.title),
          suffixIcon: getSuffixWidget(title: widget.title),
          suffixIconConstraints: BoxConstraints(),helperText: 'eg, bole road rwanda',
          // hintText: 'hint text',
          labelText: widget.title,
          // labelStyle: TextStyle(overflow: TextOverflow.fade),
          floatingLabelStyle: TextStyle(color: Colors.green.shade900),
          contentPadding:
              const EdgeInsets.only(left: 30, right: 20, top: 10, bottom: 10),
          // validator: (value) => validateInput(
          //   data: textEditingController.text,
          //   title: widget.title,
          // ),
        ));
  }
}
