import 'package:chat_wave/widgets/custumTextField.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Column(

          children: [

            SizedBox(height: 30,),
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
                          fontSize: 15, fontWeight: FontWeight.w500 ,
                      color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
            CustumTextField(text: "Name", fontWeight: FontWeight.bold, textColor: Colors.black),
            CustumTextField(text: "Name", fontWeight: FontWeight.bold, textColor: Colors.black),
            CustumTextField(text: "Name", fontWeight: FontWeight.bold, textColor: Colors.black),
            CustumTextField(text: "Name", fontWeight: FontWeight.bold, textColor: Colors.black),

            SizedBox(height: 10,),
            Container(
                width: screenWidth * 0.8,


                child: ElevatedButton(
                  onPressed: () {
                    print("Pressed");
                  },
                  child: Text("Create Account" ,style: TextStyle(color: Colors.white),) ,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xFFF3F6F6))
                    ,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16), // Button border radius
                      ),

                    ),),
                )
            ),



          ],
        ),
      ),
    );
  }
}
