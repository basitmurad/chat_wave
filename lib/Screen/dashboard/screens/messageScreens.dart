import 'package:chat_wave/widgets/circularImageview.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
        actions: [
          CircularImageview(
              width: 60,
              height: 60,
              borderColor: Colors.transparent,
              borderWidth: 0,
              imagePath: "assets/images/facebook.png")
        ],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Iconsax.search_favorite),
        ),
      ),
      body: Container(
        color: Colors.blue,
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    
                    GestureDetector(

                      child:                     Container(
                        margin: EdgeInsets.all(8),
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      ),
                        
                    )
                    ,
                    Icon(Iconsax.cloud_plus1)
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


