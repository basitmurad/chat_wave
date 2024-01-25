import 'package:chat_wave/models/chatRoomModel.dart';
import 'package:chat_wave/models/usersModels.dart';
import 'package:chat_wave/screens/ChatRoomScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

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

  Future<ChatRoomModel?> getChatRoom(UserModel targetModel) async {
    ChatRoomModel? chatRoom;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("chatRooms")
        .where("PARTICIPANTS.${widget.userModel.uid}", isEqualTo: true)
        .where("PARTICIPANTS.${targetModel.uid}", isEqualTo: true)
        .get();

    if (snapshot.docs.length > 0) {
      //fetch the ome

      print("Chat room already created");

      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatRoom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);

      chatRoom = existingChatRoom;
    } else {
      ChatRoomModel newChatRom = ChatRoomModel(
          uuid.v1(),
          {
            widget.userModel.uid.toString(): true,
            targetModel.uid.toString(): true
          },
          "");

      await FirebaseFirestore.instance.collection("chatRooms")
        ..doc(newChatRom.chatRoomID).set(newChatRom.toMap());

      chatRoom = newChatRom;
      print("new Chat room created");
    }

    return chatRoom;
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
                  //     stream: FirebaseFirestore.instance.collection("Users").where("EMAIL", isEqualTo: searchController.text).snapshots(),
                  //     builder: (context, snapshot) {
                  //       if(snapshot.connectionState == ConnectionState.active) {
                  //         if(snapshot.hasData) {
                  //           QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;
                  //
                  //           if(dataSnapshot.docs.length > 0) {
                  //             Map<String, dynamic> userMap = dataSnapshot.docs[0].data() as Map<String, dynamic>;
                  //
                  //             UserModel searchedUser = UserModel.fromMap(userMap);
                  //
                  //             showToast('  name is ${searchedUser.fullName}');
                  //             print('${searchedUser.fullName }');
                  //
                  //             return ListTile(
                  //               title: Text(searchedUser.fullName ?? 'N/A'),
                  //               subtitle: Text(searchedUser.email ?? 'N/A'),
                  //               trailing: Icon(Icons.keyboard_arrow_right),
                  //             );
                  //            }
                  //           else {
                  //             return Text("No results found!");
                  //           }
                  //
                  //         }
                  //         else if(snapshot.hasError) {
                  //           return Text("An error occured!");
                  //         }
                  //         else {
                  //           return Text("celse No results found");
                  //         }
                  //       }
                  //       else {
                  //         return CircularProgressIndicator();
                  //       }
                  //
                  //     }
                  // ),

                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .where("EMAIL", isEqualTo: searchController.text)
                        .where("EMAIL", isNotEqualTo: widget.userModel.email)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          QuerySnapshot<Map<String, dynamic>>? dataSnapshot =
                              snapshot.data
                                  as QuerySnapshot<Map<String, dynamic>>?;

                          if (dataSnapshot != null &&
                              dataSnapshot.docs.isNotEmpty) {
                            Map<String, dynamic> userMap = dataSnapshot.docs[0]
                                .data() as Map<String, dynamic>;
                            UserModel searcUser = UserModel.fromMap(userMap);

                            // Delay the toast to ensure it is called in the correct context
                            Future.delayed(Duration(seconds: 2), () {
                              showToast(' ${searcUser.fullName}');
                            });

                            return ListTile(
                              onTap: () async {
                                ChatRoomModel? chatRoom =
                                    await getChatRoom(searcUser);

                                if(chatRoom!=null)
                                  {
                                    Navigator.pop(context);
                                    Navigator.push(context, MaterialPageRoute(builder: (context){

                                      return ChatRoomScreen(

                                        targetUser:searcUser,
                                        firebaseUser: widget.firebaseUser,
                                        userModel: widget.userModel,

                                        chatRoomModel:chatRoom ,


                                      );
                                    }));
                                  }


                              },
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(searcUser.profilePic!),
                                backgroundColor: Colors.grey[500],
                              ),
                              title: Text(searcUser.fullName ?? 'No name'),
                              subtitle: Text(searcUser.email ?? 'No email'),
                              trailing: Icon(Icons.navigate_next),
                            );
                          } else {
                            return Text('No result found');
                          }
                        } else if (snapshot.hasError) {
                          return Text('An error occurred: ${snapshot.error}');
                        } else {
                          return Text('No result found');
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
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
