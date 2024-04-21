import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustumTextField extends StatelessWidget {
  const CustumTextField({
    super.key,
    required this.text,
    required this.fontWeight,
    required this.textColor,

    required this.textEditingController,
  });

  final String text;
  final FontWeight fontWeight;
  final Color textColor;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      alignment: Alignment.topLeft,
      child:  Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text as String ,
            style: TextStyle(
                fontWeight: fontWeight, color: textColor),
          ),
          SizedBox(height: 6,),
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)))
            ),
          )
        ],
      ),
    );
  }
}
