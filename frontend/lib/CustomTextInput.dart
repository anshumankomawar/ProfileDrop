import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Color(0xFFebebeb)),
        child: TextFormField(
          obscureText: widget.textName == "Password" || widget.textName == "Confirm Password",
          controller: widget.inputController,
          validator: (value) {
            return (widget.validator(value, widget.textName));
          },
          cursorColor: Color(0xFF472cdc),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: widget.textName + "...",
              hintStyle: TextStyle(color: Color(0xFF472cdc).withOpacity(0.8)),
              border: InputBorder.none),
        ),
      ),
    ));
  }
}
