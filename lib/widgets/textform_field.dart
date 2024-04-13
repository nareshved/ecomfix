
import 'package:flutter/material.dart';

Widget userTextField({String? hintTxt, Icon? preIcon,required TextEditingController myController, bool obscureBool = false, required String? Function (String? value) myValidator, })

{
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: myController,
    obscureText: obscureBool,
    validator: myValidator,
    decoration: InputDecoration(
      hintText: hintTxt,
      prefixIcon: preIcon,
    ),
  );
}