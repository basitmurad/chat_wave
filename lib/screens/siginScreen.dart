import 'package:chat_wave/screens/onboarding.dart';
import 'package:chat_wave/screens/sigupScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();

}

class _SignInState extends State<SignIn> {
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
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            leading: CupertinoButton(
              child: Icon(CupertinoIcons.arrow_left),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => OnBoarding()));
                // Your button onPressed logic here
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  child: const Text(
                    'Log in to Chatbox',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
            
            
                Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child:const Text(
                    'Welcome back! Sign in using your social\n account or email to continue us',
                    style: TextStyle(
            
                        fontSize: 14,
                        color: Colors.black,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
            
            
            
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
            
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
            
            
                ),
            
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
            
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
            
                      Container(
                        margin: EdgeInsets.only(right: 6),
                        height: 1.0, // Adjust the height of the line
                        width: 140.0,   // Width of the vertical line
                        color: Colors.black,
                      ),
                      const Text(
                        'OR',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 6),
                        height: 1.0, // Adjust the height of the line
                        width: 140.0,   // Width of the vertical line
                        color: Colors.black,
                      ),
            
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text('OR' , style: TextStyle(color: Colors.white , fontSize: 18, fontWeight: FontWeight.w500),),
                      // )
                    ],
                  ),
                ),
            
                Container(
                  margin: EdgeInsets.only(top: 12,left: 8,right: 12,bottom: 4),
                  child: TextField(
                    maxLines: 1,
            
                    decoration: InputDecoration(
                      fillColor: Colors.black38,
            
                        hintText: 'Your email',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue), // Change color as needed
                        borderRadius: BorderRadius.circular(10.0),
                        // Adjust the radius as needed
                      ),
            
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Change color as needed
                          borderRadius: BorderRadius.circular(10.0),
                        )
                    ),
            
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 4),
            
                  child: TextField(
                    maxLines: 1,
            
                    decoration: InputDecoration(
            
            
                        hintText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue), // Change color as needed
                        borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                      ),
            
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black), // Change color as needed
                        borderRadius: BorderRadius.circular(10.0),
                      )
                    ),
            
                  ),
                ),
            
            
            
            
                Container(
                  width: screenWidth*0.9,
                  height: 50,
                  margin: const EdgeInsets.only(top: 110 ),
                  child: ElevatedButton(onPressed: (){
            
            
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SigUpScreen()));
            
                  },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white70),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
            
                          ),
            
                        )
                      ),
                      child: const Text('Log In' ,style: const TextStyle(color: Colors.black38 , fontSize: 16,fontWeight: FontWeight.w700),)
            
            
                  ),
                ),
                TextButton(onPressed: (){}, child: const Text('Forget password?' ,style: TextStyle(color: Colors.green,fontSize: 16),))
            
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => OnBoarding()));

          return false;
        });
  }
}
