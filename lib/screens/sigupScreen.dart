
import 'package:chat_wave/screens/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/usersModels.dart';



class SigUpScreen extends StatefulWidget {
  const SigUpScreen({super.key});

  @override
  State<SigUpScreen> createState() => _SigUpScreenState();
}

class _SigUpScreenState extends State<SigUpScreen> {
  TextEditingController emailEditext= TextEditingController();
  TextEditingController passwordEditext= TextEditingController();
  TextEditingController confirmEditext= TextEditingController();
  TextEditingController nameEditext= TextEditingController();

  void checkValues()
  {

    String name = nameEditext.text.trim();
    String email = emailEditext.text.trim();
    String password = passwordEditext.text.trim();
    String confirmPassword = confirmEditext.text.trim();

    if(email=="" ||password=="" || confirmPassword=="" ||name=="" )
      {
        print("Fills all fields");
      }

    else if(password!=confirmPassword)
      {
        print('Password is not same');
      }

    else
      {

         signUp(email, password);
        print('SignUp successful');
      }
  }

  void signUp(String email , String password) async{

    UserCredential? userCredential;

    try{
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);


    } on FirebaseAuthException catch(ex)
    {
      print(ex.code.toString());
    }


if(userCredential!=null)
  {
    String uid = userCredential.user!.uid;
    UserModel userModel = UserModel(uid, nameEditext.text, email, "");
    await FirebaseFirestore.instance.collection("Users").doc(uid)
    .set(userModel.toMap()).then((value) => {
      print("new user created"),
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => Dashboard(userModel: userModel, firebaseUser: userCredential!.user!),
    ),


    )
    });


  }

   }

  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose()
  {
    _passwordFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return  Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Chat Wave',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.blue),
                ),
                Container(
                  margin:
                  EdgeInsets.only(top: 12, left: 8, right: 12, bottom: 4),
                  child: TextField(

                    controller: nameEditext,
                    maxLines: 1,
                    decoration: InputDecoration(
                        fillColor: Colors.black38,
                        hintText: 'Your name',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          // Change color as needed
                          borderRadius: BorderRadius.circular(10.0),
                          // Adjust the radius as needed
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          // Change color as needed
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                ),
                Container(
                  margin:
                  EdgeInsets.only(top: 12, left: 8, right: 12, bottom: 4),
                  child: TextField(

                    controller: emailEditext,
                    maxLines: 1,
                    decoration: InputDecoration(
                        fillColor: Colors.black38,
                        hintText: 'Your email',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          // Change color as needed
                          borderRadius: BorderRadius.circular(10.0),
                          // Adjust the radius as needed
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          // Change color as needed
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                ),
                Container(
                  margin:
                  EdgeInsets.only(top: 12, left: 8, right: 12, bottom: 4),
                  child: TextField(
                    controller: passwordEditext,
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: Colors.black38,
                        hintText: 'Your password',

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          // Change color as needed
                          borderRadius: BorderRadius.circular(10.0),
                          // Adjust the radius as needed
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          // Change color as needed
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                ),
                Container(
                  margin:
                  EdgeInsets.only(top: 12, left: 8, right: 12, bottom: 4),
                  child: TextField(
                    controller: confirmEditext,
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: Colors.black38,
                        hintText: 'Confirm password',

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          // Change color as needed
                          borderRadius: BorderRadius.circular(10.0),
                          // Adjust the radius as needed
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          // Change color as needed
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                ),
                Container(
                  width: screenWidth * 0.7,
                  height: 50,
                  margin: const EdgeInsets.only(top: 110),
                  child: ElevatedButton(
                      onPressed: () {

                        checkValues();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => CompleteProfile()));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.blue),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          )),
                      child: const Text(
                        'Sign Up',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      )),
                ),
              ],
            ),
          ),
        ),


      ),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Already have account?"),

            TextButton(onPressed: (){

              Navigator.pop(context);

            }, child: Text('Log In'))
          ],
        ),
      ),
    );
    // return WillPopScope(
    //     child: Scaffold(
    //       appBar: AppBar(
    //         leading: CupertinoButton(
    //           child: Icon(CupertinoIcons.arrow_left),
    //           onPressed: () {
    //             Navigator.pushReplacement(context,
    //                 MaterialPageRoute(builder: (context) => SignIn()));
    //             // Your button onPressed logic here
    //           },
    //         ),
    //       ),
    //       body: SingleChildScrollView(
    //         child: Column(
    //           children: [
    //             Container(
    //               margin: EdgeInsets.only(top: 30),
    //               alignment: Alignment.center,
    //               child: const Text(
    //                 'Sign up with Email',
    //                 style: TextStyle(
    //                     fontSize: 16,
    //                     color: Colors.black,
    //                     fontWeight: FontWeight.bold),
    //               ),
    //             ),
    //
    //
    //             Container(
    //               margin: EdgeInsets.only(top: 20),
    //               alignment: Alignment.center,
    //               child:const Text(
    //                 'Get chatting with friends and family \ntoday by signing up for our chat app!',
    //                 style: TextStyle(
    //
    //                   fontSize: 14,
    //                   color: Colors.black,
    //                 ),
    //                 textAlign: TextAlign.center,
    //               ),
    //             ),
    //
    //
    //
    //             // Padding(
    //             //   padding: const EdgeInsets.only(top: 20),
    //             //   child: Row(
    //             //
    //             //     mainAxisAlignment: MainAxisAlignment.center,
    //             //     crossAxisAlignment: CrossAxisAlignment.center,
    //             //     children: [
    //             //
    //             //
    //             //
    //             //       Padding(
    //             //         padding: const EdgeInsets.all(8.0),
    //             //         child: ClipOval(
    //             //
    //             //           child: Container(
    //             //               height: 48,
    //             //               width: 48,
    //             //               decoration: BoxDecoration(
    //             //                   border: Border.all(color: Colors.black
    //             //                       ,width: 2),
    //             //                   borderRadius: BorderRadius.circular(50)
    //             //               ),
    //             //
    //             //               child: Padding(
    //             //                 padding: const EdgeInsets.all(8.0),
    //             //                 child: Image.asset('assets/images/google.png',
    //             //                   fit: BoxFit.fill,),
    //             //               )
    //             //
    //             //
    //             //           ),
    //             //
    //             //
    //             //         ),
    //             //       ),
    //             //
    //             //       Padding(
    //             //         padding: const EdgeInsets.all(8.0),
    //             //         child: ClipOval(
    //             //
    //             //           child: Container(
    //             //               height: 50,
    //             //               width: 50,
    //             //               decoration: BoxDecoration(
    //             //                   border: Border.all(color: Colors.black
    //             //                       ,width: 2),
    //             //                   borderRadius: BorderRadius.circular(50)
    //             //               ),
    //             //
    //             //               child: Padding(
    //             //                 padding: const EdgeInsets.all(8.0),
    //             //                 child: Image.asset('assets/images/appleblack.png',
    //             //                   fit: BoxFit.fill,),
    //             //               )
    //             //
    //             //
    //             //           ),
    //             //
    //             //
    //             //         ),
    //             //       ),
    //             //
    //             //       Padding(
    //             //         padding: const EdgeInsets.all(8.0),
    //             //         child: ClipOval(
    //             //
    //             //           child: Container(
    //             //               height: 50,
    //             //               width: 50,
    //             //               decoration: BoxDecoration(
    //             //                   border: Border.all(color: Colors.black
    //             //                       ,width: 2),
    //             //                   borderRadius: BorderRadius.circular(50)
    //             //               ),
    //             //
    //             //               child: Padding(
    //             //                 padding: const EdgeInsets.all(8.0),
    //             //                 child: Image.asset('assets/images/facebook.png',
    //             //
    //             //                   fit: BoxFit.fill,),
    //             //               )
    //             //
    //             //
    //             //           ),
    //             //
    //             //
    //             //         ),
    //             //       ),
    //             //
    //             //     ],
    //             //   ),
    //             //
    //             //
    //             // ),
    //
    //             // Container(
    //             //   margin: EdgeInsets.only(top: 20),
    //             //   child: Row(
    //             //
    //             //     mainAxisAlignment: MainAxisAlignment.center,
    //             //     children: [
    //             //
    //             //       Container(
    //             //         margin: EdgeInsets.only(right: 6),
    //             //         height: 1.0, // Adjust the height of the line
    //             //         width: 140.0,   // Width of the vertical line
    //             //         color: Colors.black,
    //             //       ),
    //             //       const Text(
    //             //         'OR',
    //             //         style: TextStyle(fontSize: 18.0),
    //             //       ),
    //             //       Container(
    //             //         margin: EdgeInsets.only(left: 6),
    //             //         height: 1.0, // Adjust the height of the line
    //             //         width: 140.0,   // Width of the vertical line
    //             //         color: Colors.black,
    //             //       ),
    //             //
    //             //       // Padding(
    //             //       //   padding: const EdgeInsets.all(8.0),
    //             //       //   child: Text('OR' , style: TextStyle(color: Colors.white , fontSize: 18, fontWeight: FontWeight.w500),),
    //             //       // )
    //             //     ],
    //             //   ),
    //             // ),
    //
    //             Container(
    //               margin: EdgeInsets.only(top: 12,left: 8,right: 12,bottom: 4),
    //               child: TextField(
    //                 maxLines: 1,
    //
    //                 decoration: InputDecoration(
    //                     fillColor: Colors.black38,
    //
    //                     hintText: 'Your name',
    //                     focusedBorder: OutlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.blue), // Change color as needed
    //                       borderRadius: BorderRadius.circular(10.0),
    //                       // Adjust the radius as needed
    //                     ),
    //
    //                     enabledBorder: OutlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.black), // Change color as needed
    //                       borderRadius: BorderRadius.circular(10.0),
    //                     )
    //                 ),
    //
    //               ),
    //             ),
    //             Container(
    //               margin: EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 4),
    //
    //               child: TextField(
    //                 maxLines: 1,
    //
    //                 decoration: InputDecoration(
    //
    //
    //                     hintText: 'your email',
    //                     focusedBorder: OutlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.blue), // Change color as needed
    //                       borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
    //                     ),
    //
    //                     enabledBorder: OutlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.black), // Change color as needed
    //                       borderRadius: BorderRadius.circular(10.0),
    //                     )
    //                 ),
    //
    //               ),
    //             ),
    //             Container(
    //               margin: EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 4),
    //
    //               child: TextField(
    //                 maxLines: 1,
    //
    //                 decoration: InputDecoration(
    //
    //
    //                     hintText: 'Password',
    //                     focusedBorder: OutlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.blue), // Change color as needed
    //                       borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
    //                     ),
    //
    //                     enabledBorder: OutlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.black), // Change color as needed
    //                       borderRadius: BorderRadius.circular(10.0),
    //                     )
    //                 ),
    //
    //               ),
    //             ),
    //             Container(
    //               margin: EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 4),
    //
    //               child: TextField(
    //                 maxLines: 1,
    //
    //                 decoration: InputDecoration(
    //
    //
    //                     hintText: 'Confirm Password',
    //                     focusedBorder: OutlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.blue), // Change color as needed
    //                       borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
    //                     ),
    //
    //                     enabledBorder: OutlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.black), // Change color as needed
    //                       borderRadius: BorderRadius.circular(10.0),
    //                     )
    //                 ),
    //
    //               ),
    //             ),
    //
    //
    //
    //
    //             Container(
    //               width: screenWidth*0.9,
    //               height: 50,
    //               margin: const EdgeInsets.only(top: 110 ),
    //               child: ElevatedButton(onPressed: (){
    //                 //
    //                 // ScaffoldMessenger.of(context).showSnackBar(
    //                 //     SnackBar(
    //                 //       content: const Text('Button Clicked!'),
    //                 //       duration: const Duration(seconds: 2),
    //                 //       backgroundColor: Colors.green, // Customize the color here
    //                 //
    //                 //     ),
    //                 //
    //                 //
    //                 //
    //                 // );
    //                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
    //
    //
    //               },
    //                   style: ButtonStyle(
    //                       backgroundColor: MaterialStateProperty.all(Colors.white70),
    //                       shape: MaterialStateProperty.all(
    //                         RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(15),
    //
    //                         ),
    //
    //                       )
    //                   ),
    //                   child: const Text('Create an account' ,style: const TextStyle(color: Colors.black38 , fontSize: 16,fontWeight: FontWeight.w700),)
    //
    //
    //               ),
    //             ),
    //             // TextButton(onPressed: (){}, child: const Text('Forget password?' ,style: TextStyle(color: Colors.green,fontSize: 16),))
    //
    //           ],
    //         ),
    //       ),
    //     ),
    //     onWillPop: () async {
    //       Navigator.pushReplacement(
    //           context, MaterialPageRoute(builder: (context) => SignIn()));
    //
    //       return false;
    //     });
  }
}
