import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
    this.topImage = "assets/main_logo.png",
    this.bottomImage = "assets/main_logo.png",
  }) : super(key: key);

  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(

          alignment: Alignment.center,
          children: <Widget>[
            Image.asset('assets/background.png',height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,),
            SafeArea(child: child),
      
          ],
        ),
      ),
    );
  }
}
