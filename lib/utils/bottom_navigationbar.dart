import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: (Container(

      )),
      bottomNavigationBar: NavigationBar(
        destinations: [
          Container(color: Colors.yellow,),
          Container(color: Colors.green,),
          Container(color: Colors.blue,),
          Container(color: Colors.pink,),

        ],
      ),
    );


  }
}
