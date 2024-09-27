// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDegreeItem extends StatelessWidget {
  const CustomDegreeItem({
    super.key,
    required this.image,
    required this.number,
    required this.title,
  });
  final String image, number, title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          image,
          width: 30,
          height: 30,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          number,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
