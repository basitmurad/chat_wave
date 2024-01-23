import 'package:chat_wave/models/usersModels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchScreen extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const SearchScreen(
      {super.key, required this.userModel, required this.firebaseUser});

  // const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Search for Users..',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF4DC681)),
                  ),
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(hintText: 'Enter email...'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFF4DC681)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set the border radius as needed
                            ))),
                        child: Text(
                          'Search',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // StreamBuilder(
                  //   stream: FirebaseFirestore.instance
                  //       .collection("Users")
                  //       .where("EMAIL", isEqualTo: searchController.text)
                  //       .snapshots(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.active) {
                  //       if (snapshot.hasData) {
                  //         QuerySnapshot<Map<String, dynamic>>? dataSnapshot = snapshot.data as QuerySnapshot<Map<String, dynamic>>?;
                  //
                  //         if (dataSnapshot != null && dataSnapshot.docs.isNotEmpty) {
                  //           Map<String, dynamic> userMap = dataSnapshot.docs[0].data() as Map<String, dynamic>;
                  //           UserModel searcUser = UserModel.fromMap(userMap);
                  //
                  //           // Delay the toast to ensure it is called in the correct context
                  //           Future.delayed(Duration.zero, () {
                  //             showToast('${searcUser.email}');
                  //           });
                  //
                  //           return ListTile(
                  //             title: Text(searcUser.fullName ?? 'No name'),
                  //             subtitle: Text(searcUser.email ?? 'No email'),
                  //           );
                  //         } else {
                  //           return Text('No result found');
                  //         }
                  //       } else if (snapshot.hasError) {
                  //         return Text('An error occurred: ${snapshot.error}');
                  //       } else {
                  //         return Text('No result found');
                  //       }
                  //     } else {
                  //       return CircularProgressIndicator();
                  //     }
                  //   },
                  // )

                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .where("EMAIL", isEqualTo: searchController.text)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {

                        if(snapshot.hasData)
                          {

                          }
                        else{

                        }

                      } else {

                        return CircularProgressIndicator();
                      }

                      //    if (snapshot.connectionState == ConnectionState.active) {
                      //  if (snapshot.hasData) {
                      //    QuerySnapshot dataSnapshot =
                      //        snapshot.data! as QuerySnapshot;
                      //
                      //    if (dataSnapshot.docs.length > 0) {
                      //      Map<String, dynamic> userMap = dataSnapshot.docs[0]
                      //          .data() as Map<String, dynamic>;
                      //
                      //      UserModel searcUser = UserModel.fromMap(userMap);
                      //
                      //      // return ListTile(
                      //      //   title: Text(searcUser.fullName!),
                      //      //   subtitle: Text(searcUser.email!),
                      //      // );
                      //    }
                      //    else
                      //      {
                      //        return Text('No result found');
                      //      }
                      //  } else if (snapshot.hasError) {
                      //    return Text('An error occurred!');
                      //  } else {
                      //    return Text('No result found');
                      //  }
                      // } else {
                      //  return Text('No result found');
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
