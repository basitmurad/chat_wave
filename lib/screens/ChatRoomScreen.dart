import 'package:chat_wave/models/chatRoomModel.dart';
import 'package:chat_wave/models/messageModel.dart';
import 'package:chat_wave/models/usersModels.dart';
import 'package:chat_wave/screens/searchScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  final UserModel targetUser;
  final ChatRoomModel chatRoomModel;

  final UserModel userModel;
  final User firebaseUser;

  const ChatRoomScreen(
      {super.key,
      required this.targetUser,
      required this.chatRoomModel,
      required this.userModel,
      required this.firebaseUser});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  TextEditingController messageController = TextEditingController();

  void sendMessage() async {
    String message = messageController.text.trim();
    messageController.clear();

    if (message != "") {
      // Send Message
      MessageModel messageModel = MessageModel(
        uuid.v1(),
        widget.userModel.uid,
        message,
        false,
        Timestamp.now(),
      );

      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatRoomModel.chatRoomID)
          .collection("messages")
          .doc(messageModel.messageId)
          .set(messageModel.toMap());

      widget.chatRoomModel.lastMessage = message;
      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatRoomModel.chatRoomID)
          .set(widget.chatRoomModel.toMap());

      print("message send");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child:
        AppBar(
          backgroundColor: Color(0xFF4DC681),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(widget.targetUser.profilePic.toString()),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.targetUser.fullName.toString(),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                  child: Container(

                    padding: EdgeInsets.symmetric(horizontal: 10),
                color: Colors.white38,
                child:
                    // StreamBuilder(
                    //   stream: FirebaseFirestore.instance.collection("chatrooms").doc(widget.chatRoomModel.chatRoomID).collection("messages").orderBy("SENDON").snapshots(),
                    //   builder: (context, snapshot) {
                    //     if(snapshot.connectionState == ConnectionState.active) {
                    //       if(snapshot.hasData) {
                    //         QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;
                    //
                    //         return ListView.builder(
                    //           reverse: true,
                    //           itemCount: dataSnapshot.docs.length,
                    //           itemBuilder: (context, index) {
                    //             MessageModel currentMessage = MessageModel.fromMap(dataSnapshot.docs[index].data() as Map<String, dynamic>);
                    //
                    //             return Text(currentMessage.textMessage.toString());
                    //
                    //             // return Row(
                    //             //   mainAxisAlignment: (currentMessage.sender == widget.userModel.uid) ? MainAxisAlignment.end : MainAxisAlignment.start,
                    //             //   children: [
                    //             //     Container(
                    //             //         margin: EdgeInsets.symmetric(
                    //             //           vertical: 2,
                    //             //         ),
                    //             //         padding: EdgeInsets.symmetric(
                    //             //           vertical: 10,
                    //             //           horizontal: 10,
                    //             //         ),
                    //             //         decoration: BoxDecoration(
                    //             //           color: (currentMessage.sender == widget.userModel.uid) ? Colors.grey : Theme.of(context).colorScheme.secondary,
                    //             //           borderRadius: BorderRadius.circular(5),
                    //             //         ),
                    //             //         child: Text(
                    //             //           currentMessage.textMessage.toString(),
                    //             //           style: TextStyle(
                    //             //             color: Colors.white,
                    //             //           ),
                    //             //         )
                    //             //     ),
                    //             //   ],
                    //             // );
                    //           },
                    //         );
                    //       }
                    //       else if(snapshot.hasError) {
                    //         return Center(
                    //           child: Text("An error occured! Please check your internet connection."),
                    //         );
                    //       }
                    //       else {
                    //         return Center(
                    //           child: Text("Say hi to your new friend"),
                    //         );
                    //       }
                    //     }
                    //     else {
                    //       return Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     }
                    //   },
                    // ),

                    StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("chatrooms")
                      .doc(widget.chatRoomModel.chatRoomID)
                      .collection("messages").orderBy("SENDON" , descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        QuerySnapshot querySnapshot =
                            snapshot.data as QuerySnapshot;

                        return ListView.builder(
                          reverse: true,
                          itemCount: querySnapshot.docs.length,
                          itemBuilder: (context, index) {
                            MessageModel currentMessage = MessageModel.fromMap(
                                querySnapshot.docs[index].data()
                                    as Map<String, dynamic>);

                            return Row(
                              mainAxisAlignment: (currentMessage.sender==widget.userModel.uid
                              )? MainAxisAlignment.end:
                              MainAxisAlignment.start,
                              children: [
                            Container(


                            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                            margin: EdgeInsets.symmetric(vertical: 2,horizontal: 4),
                            decoration: BoxDecoration(
                            color: (currentMessage.sender==widget.userModel.uid)?Colors.grey:Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(5)

                            ),

                            child: Text('${currentMessage.textMessage.toString()} ' ,style: TextStyle(fontSize: 16),))

                            ],
                            );

                          },
                        );
                      } else if (snapshot.hasError) {
                        print("Some thing went wrong");
                      } else {
                        return Center(
                          child: Text("Say hi to your new friend "),
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Text('no messae');
                  },
                ),
              )),
              Container(
                padding: EdgeInsets.only(bottom: 6, left: 10, right: 10),
                color: Colors.white54,
                child: Row(
                  children: [
                    Flexible(
                        child: TextField(
                      controller: messageController,
                      maxLines: null,
                      decoration: InputDecoration(hintText: 'Type Message..'),
                    )),
                    IconButton(
                        onPressed: () {
                          sendMessage();
                        },
                        icon: Icon(
                          Icons.send,
                          color: Color(0xFF4DC681),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
