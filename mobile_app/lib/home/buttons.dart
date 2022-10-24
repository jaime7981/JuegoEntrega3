import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../globals_vars.dart';
class MenuButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const MenuButton(
      {Key? key,
   
      required this.buttonText,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height,
        width = MediaQuery.of(context).size.width;
    return TextButton(
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(Size(width * .7, width * .2)),
          alignment: Alignment.center,
          foregroundColor: MaterialStateProperty.all(kPrimaryColor),
          backgroundColor: MaterialStateProperty.all(kPrimaryLightColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width * .02),
          )),
          textStyle: MaterialStateProperty.all(TextStyle(
            fontSize: width * .12,
            fontWeight: FontWeight.bold,
          ))),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: width * .02),
          Text(buttonText)
        ],
      ),
    );
  }
}