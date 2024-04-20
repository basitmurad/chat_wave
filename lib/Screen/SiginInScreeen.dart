import 'package:flutter/material.dart';

import '../widgets/circularImageview.dart';
import '../widgets/custumTextField.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        "Login into Chatbox",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        " Welcome back! Sign in using your social\n       account or email to continue us",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("Click");
                    },
                    child: CircularImageview(
                      width: 50,
                      height: 60,
                      borderColor: Colors.black,
                      borderWidth: 2,
                      imagePath: 'assets/images/google.png',
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Click");
                    },
                    child: CircularImageview(
                      width: 50,
                      height: 60,
                      borderColor: Colors.black,
                      borderWidth: 2,
                      imagePath: 'assets/images/facebook.png',
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Click");
                    },
                    child: CircularImageview(
                      width: 50,
                      height: 60,
                      borderColor: Colors.black,
                      borderWidth: 2,
                      imagePath: 'assets/images/apple.png',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        height: 10,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'OR',
                        style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.none,
                            color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        height: 10,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                width: screenWidth * 0.8,


                child: ElevatedButton(
                    onPressed: () {
                      print("Pressed");
                    },
                    child: Text("Sign in" ,style: TextStyle(color: Colors.white),) ,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF24786D))
                      ,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16), // Button border radius
                    ),

                ),),
              )
              ),
              const SizedBox(
                height: 10,
              ),

              TextButton(onPressed: (){}, child: Text("Forgot Password?" ,style: TextStyle(color: Color(0xFF24786D)),))
            ],
          ),
        ),
      ),
    );
  }
}
