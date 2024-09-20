import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  String text;
  bool isChecked;
  Map checkedInfo;
  dynamic setState;
  CustomCheckbox(
      {super.key,
      required this.text,
      required this.isChecked,
      required this.checkedInfo,
      required this.setState});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: widget.checkedInfo[widget.text]!,
          onChanged: (bool? value) {
            widget.setState(() {
              widget.checkedInfo[widget.text] =
                  !widget.checkedInfo[widget.text];
            });
          },
        ),
        Expanded(
          child: Text(
            widget.text,
            softWrap: true,
          ),
        )
      ],
    );
  }
}
