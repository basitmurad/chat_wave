import 'package:chat_wave/widgets/circularImageview.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.black],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 10 ,right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          // Align children at the start

          children: [
            const SizedBox(
              height: 60,
            ),
            const Text(
              "Connect\nfriends\neasily &\nquickly",
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8, bottom: 20),
              child: Text(
                "Our chat app is the perfect way to stay \nconnected with friends and family.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                GestureDetector(
                  onTap: (

                      ){
                    print("Click");
                  },
                  child: CircularImageview(width: 50, height: 60, borderColor: Colors.white ,borderWidth: 2, imagePath: 'assets/images/google.png',),
                ),

                const SizedBox(width: 15,),
                GestureDetector(
                  onTap: (

                      ){
                    print("Click");
                  },
                  child: CircularImageview(width: 50, height: 60, borderColor: Colors.white ,borderWidth: 2, imagePath: 'assets/images/facebook.png',),
                ),
                const SizedBox(width: 15,),

                GestureDetector(
                  onTap: (

                      ){
                    print("Click");
                  },
                  child: CircularImageview(width: 50, height: 60, borderColor: Colors.white ,borderWidth: 2, imagePath: 'assets/images/apple.png',),
                ),
              ],
            ),

             const SizedBox(height: 30,),
             const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    height: 10,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Or' ,
                  style: TextStyle(fontSize: 18,
                    decoration: TextDecoration.none,
                    color: Colors.white

                  ),),
                ),
                Expanded(
                  child: Divider(
                    height: 10,
                    color: Colors.white,
                  ),
                ),

              ],
            ),

            const SizedBox( height: 35,),
            Container(
              height: 50,
              width: 300,
              decoration: const BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.all(Radius.circular(9))
              ),
              alignment: Alignment.center,
              child: const Text("Sign Up with email",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,

                  decoration: TextDecoration.none,
                fontSize: 12
              ),),

            ),


            const SizedBox(height: 30,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                const Text("Existing Account?" ,
                style: TextStyle(fontSize: 14 ,
                  decoration: TextDecoration.none,
                  color: Colors.white
                ),),
                const SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){
                    print("Click");
                  },
                  child: const Text("Login In" ,
                  style: TextStyle(fontSize: 14 ,
                    decoration: TextDecoration.none,
                    color: Colors.white
                  ),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

