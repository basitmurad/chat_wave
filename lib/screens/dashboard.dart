import 'package:chat_wave/models/usersModels.dart';
import 'package:chat_wave/screens/searchScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  // const Dashboard({Key? key}) : super(key: key);
  final UserModel userModel;
  final User firebaseUser;

  const Dashboard(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Chat App'),



      ),
      body: SafeArea(
        child: Container(
          
          child: Column(

            children: [



              FloatingActionButton(onPressed: (){


              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                   SearchScreen(userModel: widget.userModel, firebaseUser: widget.firebaseUser)));
            } , child: Icon(Icons.next_plan),)],
          ),
        ),
      ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: (){
    //
    //       Navigator.push(context, MaterialPageRoute(builder: (context)=>
    //       SearchScreen(userModel: widget.userModel, firebaseUser: widget.firebaseUser)));
    //     },
    // child:  Icon(Icons.search_rounded),
    // ),


    );
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.white70,
    //     title: Text(
    //       'Home',
    //       style: TextStyle(
    //           fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    //     ),
    //     centerTitle: true,
    //     leading: IconButton(
    //       onPressed: () {},
    //       icon: Icon(
    //         Icons.search, // Use Icons instead of CupertinoIcons
    //       ),
    //       iconSize: 20,
    //       color: Colors.red, // Icon color
    //     ),
    //     actions: [
    //       IconButton(
    //         onPressed: () {},
    //         icon: ClipOval(
    //           child: Image.network(
    //             'https://img.freepik.com/free-photo/colorful-heart-air-balloon-shape-collection-concept-isolated-color-background-beautiful-heart-ball-event_90220-1047.jpg?t=st=1705656101~exp=1705656701~hmac=0cc98bbd5986a31f6418563db5fe0fb8e722aa75ec9365d3ed4ba52cdd85a43a',
    //             fit: BoxFit.cover,
    //             width: 40,
    //             height: 40,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    //   body:
    //
    //   // Column(
    //   //         children: [
    //   //           Container(
    //   //             height: 90,
    //   //             margin: EdgeInsets.only(top: 8),
    //   //             child: ListView.builder(
    //   //               padding: EdgeInsets.zero,
    //   //               scrollDirection: Axis.horizontal,
    //   //               itemCount: 10,
    //   //               itemBuilder: (context, index) {
    //   //                 return Padding(
    //   //                   padding: EdgeInsets.only(left: 4, right: 2),
    //   //                   child: Center(
    //   //                     child: Column(
    //   //                       children: [
    //   //                         Container(
    //   //                           margin: EdgeInsets.zero,
    //   //                           width: 55,
    //   //                           height: 55,
    //   //                           decoration: BoxDecoration(
    //   //                             shape: BoxShape.circle,
    //   //                             color: Colors.orange,
    //   //                           ),
    //   //                         ),
    //   //                         Text(
    //   //                           'basit',
    //   //                           style: TextStyle(
    //   //                               fontSize: 14,
    //   //                               color: Colors.white,
    //   //                               fontWeight: FontWeight.w400),
    //   //                         )
    //   //                       ],
    //   //                     ),
    //   //                   ),
    //   //                 );
    //   //               },
    //   //             ),
    //   //           ),
    //   //           Image.network(
    //   //             'https://img.freepik.com/free-photo/colorful-heart-air-balloon-shape-collection-concept-isolated-color-background-beautiful-heart-ball-event_90220-1047.jpg?t=st=1705656101~exp=1705656701~hmac=0cc98bbd5986a31f6418563db5fe0fb8e722aa75ec9365d3ed4ba52cdd85a43a',
    //   //           ),
    //   //         ],
    //   //       ),
    //
    //   backgroundColor: Color(0xFF1E1E1E),
    //   bottomNavigationBar: BottomNavigationBar(
    //     currentIndex: _currentIndex,
    //     onTap: (index) {
    //       setState(() {
    //         _currentIndex = index;
    //       });
    //     },
    //     items: [
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.home),
    //         label: 'Home',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.business),
    //         label: 'Business',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.school),
    //         label: 'School',
    //       ),
    //     ],
    //   ),
    // );
  }
}
