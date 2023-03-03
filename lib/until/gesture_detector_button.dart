import 'package:flutter/material.dart';


class GestureDetectorButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  const GestureDetectorButton(
      {super.key, required this.onTap, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(iconData,size: 25,),
    );
  }
}
