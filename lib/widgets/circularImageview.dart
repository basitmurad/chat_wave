import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularImageview extends StatelessWidget {
   CircularImageview({
    super.key,
     required this.width,
     required this.height,
     required this.borderColor,
     required this.borderWidth,
     required this.imagePath,
  });

  final double width;
   final  double height;
   final Color borderColor;
   final double borderWidth;
   final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
      ),


      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipOval(
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
