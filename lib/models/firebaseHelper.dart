import 'package:chat_wave/models/usersModels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

 class FirebaseHelper
{
  static Future<UserModel?> getUserModel(String uid) async{


    UserModel? userModel;


   DocumentSnapshot snapshotUser = await FirebaseFirestore.instance.collection("Users").doc(uid).get();

   if(snapshotUser.data() !=null)
     {
       userModel = UserModel.fromMap(snapshotUser.data() as Map<String , dynamic>);


     }
   return userModel;
  }
}