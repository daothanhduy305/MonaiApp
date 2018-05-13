import 'package:flutter/material.dart';

Widget textBox(String labelText,
        {TextInputType keyboardType = TextInputType.text,
        String hintText,
        bool enabled = true,
        ValueChanged<String> onChanged,
        TextEditingController controller}) =>
    Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Theme(
          data: ThemeData(
            disabledColor: Colors.black,
          ),
          child: TextField(
            enabled: enabled,
            onChanged: onChanged,
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              labelStyle: TextStyle(color: Colors.black87),
              border: OutlineInputBorder(),
            ),
            keyboardType: keyboardType,
            controller: controller,
          )),
    );
