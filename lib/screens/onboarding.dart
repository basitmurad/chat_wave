import 'package:chat_wave/screens/siginScreen.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
   OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return

      SingleChildScrollView(
        child: Scaffold(
        body: Container(

            padding: EdgeInsets.only(top: 50),
            decoration: const BoxDecoration(
          
                gradient: LinearGradient
                  (
                  end: Alignment.topLeft,
                  begin: Alignment.bottomRight,
          
                  colors: [Colors.purple, Colors.black], // Set your desired gradient colors
          
                )
            ),
            child: Column(
          
          
          
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'ChatWave',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                ),
          
          
                Container(
                  margin: EdgeInsets.all(8),
          
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Connect\nFriends\neasily &\nquickly',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.w400, height: 1.1 ,
                        color: Colors.white),
                  ),
                ),
          
          
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 16 ,top: 8),
                  child: Text(
                    'Our chat app is the perfect way \nto stayconnected with\nfriends and family.',
                    style: TextStyle(fontSize: 16 ,
                        color: Colors.white60),
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
                        color: Colors.white70,
                      ),
                      Text(
                        'OR',
                        style: TextStyle(fontSize: 18.0 ,color: Colors.white),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 6),
                        height: 1.0, // Adjust the height of the line
                        width: 140.0,   // Width of the vertical line
                        color: Colors.white70,
                      ),
          
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text('OR' , style: TextStyle(color: Colors.white , fontSize: 18, fontWeight: FontWeight.w500),),
                      // )
                    ],
                  ),
                ),
          
                Container(
                  margin: EdgeInsets.all(20),
          
                  height: 45,
                  alignment: Alignment.center,
          
          
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                  ),
                  child:
                  Text('Sign up with email' , style: TextStyle(color: Colors.black , fontSize: 20),),
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
                                  border: Border.all(color: Colors.white
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
                                  border: Border.all(color: Colors.white
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
                                  border: Border.all(color: Colors.white
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
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [const Text('Existing Account?') , TextButton(onPressed: (){
          
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
                  }, child: const Text(
                    'Log In' , style: TextStyle(color: Colors.white , fontSize: 14), maxLines: 1,))],
                )
              ],
            ),
          ),
        
        
            ),
      );

  }
}

