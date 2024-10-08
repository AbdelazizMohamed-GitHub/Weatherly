import 'package:flutter/material.dart';
import 'package:weatherly/core/utils/app_color.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    required this.text,
    required this.textType, required this.iconButton, this.onChanged, this.onFieldSubmitted,

  });
  final String text;
  final TextInputType textType;
  final IconButton iconButton;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return TextFormField(onChanged:onChanged ,autofocus: true,
      keyboardType: textType,
      textInputAction: TextInputAction.search,
      onFieldSubmitted:onFieldSubmitted ,
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
