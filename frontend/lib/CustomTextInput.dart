import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextInput extends StatefulWidget {
  final TextEditingController inputController;
  final Function validator;
  final String textName;
  const CustomTextInput(
      {Key? key,
      required this.inputController,
      required this.validator,
      required this.textName})
      : super(key: key);

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
        child: TextFormField(
          controller: widget.inputController,
          validator: (value) {
            return (widget.validator(value, widget.textName));
          },
          cursorColor: Color(0xFF472cdc),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Color(0xFFebebeb),
            filled: true,
            contentPadding: EdgeInsets.all(12),
            hintText: widget.textName + "...",
            hintStyle: TextStyle(color: Color(0xFF472cdc).withOpacity(0.8))),
        ),
      ));
  }
}
