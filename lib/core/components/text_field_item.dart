import 'package:flutter/material.dart';

Widget TextFieldItem(title,
    {required controller,
    void Function(String)? onChanged,
    Function(String)? onSubmit}) {
  return Padding(
    padding: const EdgeInsets.all(15).copyWith(bottom: 30, top: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          onFieldSubmitted: onSubmit,
          style: TextStyle(
            fontSize: 19,
            color: Colors.grey[700],
          ),
        ),
      ],
    ),
  );
}

Widget TextFieldAuth(
  text, {
  void Function(String)? onChanged,
  required TextEditingController controller,
  bool label = true,
}) {
  return TextFormField(
    controller: controller,
    onChanged: onChanged,
    decoration: InputDecoration(
      hintText: label ? null : text,
      labelText: label ? text : null,
      border: const OutlineInputBorder(),
    ),
  );
}
