import 'package:chat_wave/screens/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
    appBar: AppBar(
      leading: CupertinoButton(
        child: Icon(CupertinoIcons.arrow_left),
        onPressed: () {

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
          // Your button onPressed logic here
        },
      ),
    ),



    ));
  }

}
