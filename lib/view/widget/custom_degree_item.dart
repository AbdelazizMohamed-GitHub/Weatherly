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
        const SizedBox(
          height: 5,
        ),
        Text(
          number,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
