import 'package:chat_wave/screens/siginScreen.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        decoration: BoxDecoration(

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
            Text(
              'ChatWave',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),


            Container(
              margin: EdgeInsets.all(8),

              alignment: Alignment.topLeft,
              child: Text(
                'Connect\nFriends\neasily &\nquickly',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w400, height: 1.1 ,
                    color: Colors.white70),
              ),
            ),


            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.all(8),
              child: Text(
                'Our chat app is the perfect way to stay\nconnected with friends and family.',
                style: TextStyle(fontSize: 18 ,
                    color: Colors.white),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(

                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black
                                  ,width: 2),
                              borderRadius: BorderRadius.circular(50)
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/apple.png',
                              fit: BoxFit.fill,),
                          )


                      ),


                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(

                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black
                                  ,width: 2),
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
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(

                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black
                                  ,width: 2),
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
                  Text(
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
              margin: EdgeInsets.all(20),

              height: 50,
              alignment: Alignment.center,


              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
              ),
              child:
              Text('Sign up with email' , style: TextStyle(color: Colors.black , fontSize: 20),),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [Text('Existing Account?') , TextButton(onPressed: (){

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
              }, child: Text(
                'Login In' , style: TextStyle(color: Colors.white , fontSize: 14), maxLines: 1,))],
            )
          ],
        ),
      ),

    );

  }
}

