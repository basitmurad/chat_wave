import 'package:chat_wave/screens/completeProfile.dart';
import 'package:chat_wave/screens/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog2/progress_dialog2.dart';

import '../models/usersModels.dart';

class SigUpScreen extends StatefulWidget {
  const SigUpScreen({super.key});

  @override
  State<SigUpScreen> createState() => _SigUpScreenState();
}

class _SigUpScreenState extends State<SigUpScreen> {
  TextEditingController emailEditext = TextEditingController();
  TextEditingController passwordEditext = TextEditingController();
  TextEditingController confirmEditext = TextEditingController();
  TextEditingController nameEditext = TextEditingController();

  bool isPasswordVisible = false;

   ProgressDialog? _progressDialog;

  @override
  void initState() {
    super.initState();
    _progressDialog = ProgressDialog(context);
  }


  void showProgress() {
    _progressDialog!.show();
  }

  void hideProgress() {
    if (mounted) {
      _progressDialog?.hide();
    }  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }




  void checkValues() {
    String email = emailEditext.text.trim();
    String password = passwordEditext.text.trim();
    String confirmPassword = confirmEditext.text.trim();

    if (email == "" || password == "" || confirmPassword == "") {
      showToast('Fills all fields');
      print("Fills all fields");
    } else if (password != confirmPassword) {
      print('Password is not same');
      showToast('Password is not same');

    } else {
      showProgress();
      signUp(email, password);
      print('SignUp successful');
    }
  }

  void signUp(String email, String password) async {
    UserCredential? userCredential;

    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      hideProgress();

      print(ex.code.toString());
    }

    if (userCredential != null) {
      String uid = userCredential.user!.uid;
      UserModel userModel = UserModel(uid, nameEditext.text, email, "");
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .set(userModel.toMap())
          .then((value) => {
                print("new user created"),
        hideProgress(),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompleteProfile(
                        userModel: userModel,
                        firebaseUser: userCredential!.user!),
                  ),
                )
              });
    }
  }

  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SingleChildScrollView(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  padding: EdgeInsets.zero,
                  height: 120,
                  width: 100,
                  child:
                  Image(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.fitHeight,// set the width
                    alignment: Alignment.topLeft,  // set the alignment
                  )
                  ,

                ),
                Container(
                    alignment: Alignment.center,
                    child: Text('ChatWave' , style: TextStyle(color: Color(0xFF4DC681) , fontSize: 20 , fontWeight: FontWeight.bold),)),



                SizedBox(height: 35,),

                TextField(
                  controller: emailEditext,
                  maxLines: 1,
                  decoration: InputDecoration(

                    prefixIcon: Icon(Icons.email),
                      fillColor: Colors.black38,
                      labelText: 'Email',
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
                SizedBox(height: 15,),

                TextField(
                  controller: passwordEditext,
                  maxLines: 1,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password_rounded),

                      fillColor: Colors.black38,
                      labelText: 'Password',
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
                      ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(height: 15,),
                TextField(
                  controller: confirmEditext,
                  maxLines: 1,

                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password_rounded),
                      fillColor: Colors.black38,
                      labelText: 'Confirm password',
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
                      )
                  ,
                  ),
                ),

                SizedBox(height: 50,),
                Align(
                  alignment: Alignment.center,


                  child: SizedBox(
                    height:
                    50,
                    width: 200,
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
                                MaterialStateProperty.all(Color(0xFF4DC681)),
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
                ),
                SizedBox(height: 70,),
                Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [



                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ClipOval(

                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black
                                    ,width: 1.5),
                                borderRadius: BorderRadius.circular(50)
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/google.png',
                                fit: BoxFit.fill,),
                            )


                        ),


                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ClipOval(

                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black
                                    ,width: 1.5),
                                borderRadius: BorderRadius.circular(50)
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/appleblack.png',
                                fit: BoxFit.fill,),
                            )


                        ),


                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ClipOval(

                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black
                                    ,width: 1.5),
                                borderRadius: BorderRadius.circular(50)
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/facebook.png',

                                fit: BoxFit.fill,),
                            )


                        ),


                      ),
                    ),

                  ],
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
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Log In' , style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700 ,color: Color(0xFF4DC681)),))
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
