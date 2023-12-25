import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  final bool isPassword;
  final String lable;
  final Color filedColors;
  final Icon suffixicon;
  const CustomTextFiled(
      {super.key,
      required this.isPassword,
      required this.lable,
      required this.filedColors,
      required this.suffixicon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      decoration: InputDecoration(
          label: Text(lable),
          labelStyle: TextStyle(color: filedColors),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          suffixIcon: suffixicon,
          suffixIconColor: filedColors,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              )),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: filedColors),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.red),
          )),
    );
  }
}
