import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildTextField(String label, TextEditingController controller) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
  );
}