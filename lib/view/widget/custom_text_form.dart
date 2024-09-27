import 'package:flutter/material.dart';
import 'package:weatherly/core/utils/app_color.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    required this.text,
    required this.textController,
    required this.textType, required this.iconButton, this.onChanged,
  });
  final String text;
  final TextEditingController? textController;
  final TextInputType textType;
  final IconButton iconButton;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(onChanged:onChanged ,
      keyboardType: textType,
      controller: textController,
      decoration: InputDecoration(suffixIcon: iconButton,
        contentPadding:const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        filled: true,
        fillColor: Colors.white,
        hintText: text,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.pColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
