import 'package:chat_wave/screens/dashboard.dart';

import 'package:chat_wave/screens/sigupScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:progress_dialog2/progress_dialog2.dart';

import '../models/usersModels.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {



  final FocusNode _passwordFocusNode = FocusNode();
  TextEditingController emailEditext= TextEditingController();
  TextEditingController passwordEditext= TextEditingController();

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
    _progressDialog!.hide();
  }

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



  void checkValues()
  {

    String email = emailEditext.text.trim();
    String password = passwordEditext.text.trim();

    if(email=="" ||password=="")
    {
      print("Fills all fields");
      showToast('Fills all fields');
    }

    else
    {
      showProgress();

      login(email, password);

    }
  }

  void login(String email , String password) async{

    UserCredential? userCredential;

    try{
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);


    } on FirebaseAuthException catch(ex)
    {
      hideProgress();
      showToast('Try again \n something went wrong');

      print(ex.code.toString());
    }


    if(userCredential!=null)
    {
      String uid = userCredential.user!.uid;

      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection("Users").doc(uid)
      .get();
      UserModel userModel = UserModel.fromMap(userData.data() as
      Map<String , dynamic >);
      showToast('Login successfully');
      hideProgress();

      Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard(userModel: userModel, firebaseUser: userCredential!.user!)));
      print('Login successfully');


    }

  }


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
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: SingleChildScrollView(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [



                Container(
                  padding: EdgeInsets.zero,
                  height: 100,
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



                SizedBox(
                    height: 10,),

                Text(
                  'Welcome back!\nSign in using your social\nAccount or email to continue us',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black),
                ),

                SizedBox(height: 25,),

                TextField(
                  controller: emailEditext,
                  maxLines: 1,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                      fillColor: Colors.black38,
                      labelText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
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
                SizedBox(height: 25,),
                TextField(
                  controller:  passwordEditext,
                  maxLines: 1,

                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                      fillColor: Colors.black38,
                      prefixIcon: Icon(Icons.password_rounded),

                      labelText: 'Password',

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
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

                  )),



                SizedBox(height: 50,),

                Align(
                  alignment: Alignment.center,
                  child:                 SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {

                          checkValues();
                          print('Sign up screen');

                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => SigUpScreen()));
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
                          'Log In',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        )),
                  ),

                ),

            SizedBox(height: 50,),
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

                                        child: IconButton(
                                          onPressed: (){

                                            print('clicked');

                                            siginInWithGoogle();
                                          },
                                          icon: Image.asset('assets/images/google.png'),  
                                        ),
                                        


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
                // Container(
                //   width: screenWidth * 0.7,
                //   height: 50,
                //   margin: const EdgeInsets.only(top: 110),
                //   child: ElevatedButton(
                //       onPressed: () {
                //
                //         // checkValues();
                //         print('Sign up screen');
                //
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => SearchScreen(wi)));
                //       },
                //       style: ButtonStyle(
                //           backgroundColor:
                //               MaterialStateProperty.all(Colors.blue),
                //           shape: MaterialStateProperty.all(
                //             RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(15),
                //             ),
                //           )),
                //       child: const Text(
                //         'Log In',
                //         style: const TextStyle(
                //             color: Colors.white,
                //             fontSize: 16,
                //             fontWeight: FontWeight.w700),
                //       )),
                // ),

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
            Text("Don't have account?"),

            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SigUpScreen()));
              
            }, child: Text('Sign Up', style: TextStyle(color: Color(0xFF4DC681) , fontSize: 16, fontWeight: FontWeight.w700, ),))
          ],
        ),
      ),
    );

  }
  void siginInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleSignInAuth =
    await googleSignInAccount?.authentication;

    AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuth?.accessToken,
      idToken: googleSignInAuth?.idToken,
    );

    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(authCredential);

    if (userCredential != null) {
      print("User ID: ${userCredential.user!.uid}");
      print("Email: ${userCredential.user!.email}");
      print("Display Name: ${userCredential.user!.displayName}");
      print("Photo URL: ${userCredential.user!.photoURL}");

      // Additional logic if needed

      Fluttertoast.showToast(msg: "Account created");




      if (userCredential != null) {
        String uid = userCredential.user!.uid;
        UserModel userModel = UserModel(uid, userCredential.user!.displayName ,userCredential.user!.email ,userCredential.user!.photoURL );
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
              builder: (context) => Dashboard(
                  userModel: userModel,
                  firebaseUser: userCredential.user!),
            ),
          )
        });
      }

    }
  }

//   void siginInWithGoogle() async{
//
//     GoogleSignInAccount? googleSignInAccount  = await GoogleSignIn().signIn();
//     GoogleSignInAuthentication? googleSign = await googleSignInAccount?.authentication;
// AuthCredential authCredential = GoogleAuthProvider.credential(
//   accessToken:  googleSign?.accessToken,
//   idToken: googleSign?.idToken
// );
//
//
//     UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);
//
//
// if(userCredential!=null)
//   {
//     print(userCredential.user!.email);
//     print(userCredential.user!.displayName);
//     print(userCredential.user!.photoURL);
//     Fluttertoast.showToast(msg: "Accont created");
//   }
//
//   }
}
