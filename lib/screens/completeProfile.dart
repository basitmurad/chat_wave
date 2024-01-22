import 'dart:io';
import 'dart:math';

import 'package:chat_wave/models/usersModels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class CompleteProfile extends StatefulWidget {

  final UserModel userModel;
  final User firebaseUser;

  const CompleteProfile({super.key, required this.userModel,  required this.firebaseUser});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();


}

class _CompleteProfileState extends State<CompleteProfile> {


   File? imageFile;
  TextEditingController fullNameController = TextEditingController();

  void selectImage(ImageSource imageSource) async{

    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);

    if(pickedFile!=null)
    {
      print('Before $pickedFile');
setState(() {
  imageFile = File(pickedFile.path);

});
      print('after $imageFile');

    }

  }

  void showPhotoOption() {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Upload Profile Picture'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: (){
                Navigator.pop(context);

                selectImage(ImageSource.gallery);

              },
              leading: Icon(Icons.photo_album),
              title: const Text('Select from gallery'),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);

                selectImage(ImageSource.camera);

              },
              leading: Icon(Icons.camera),

              title: const Text('Take Photo'),
            ),


          ],
        ),
      );
    });
  }


   void checkValues() {
     String fullname = fullNameController.text.trim();

     if(fullname == "" || imageFile == null) {
       print("Please fill all the fields");
     }
     else {




       Logger li = Logger();
       li.d('Uploading data');

uploadData();
     }
   }

   void uploadData() async {
     try {
       // UIHelper.showLoadingDialog(context, "Uploading image..");

       UploadTask uploadTask = FirebaseStorage.instance.ref("profilepictures").child(widget.userModel.uid.toString()).putFile(imageFile!);

       TaskSnapshot snapshot = await uploadTask;

       String? imageUrl = await snapshot.ref.getDownloadURL();
       String? fullname = fullNameController.text.trim();

       widget.userModel.fullName = fullname;
       widget.userModel.profilePic = imageUrl;

       await FirebaseFirestore.instance.collection("users").doc(widget.userModel.uid).set(widget.userModel.toMap()).then((value) {
         print('Data uploaded to Firestore');
       });
     } catch (error) {
       print('Error uploading data: $error');
       // Add any additional error handling, logging, or UI feedback as needed
     }
   }


   // void uploadData() async {
   //
   //   // UIHelper.showLoadingDialog(context, "Uploading image..");
   //
   //   UploadTask uploadTask = FirebaseStorage.instance.ref("profilepictures").child(widget.userModel.uid.toString()).putFile(imageFile!);
   //
   //   TaskSnapshot snapshot = await uploadTask;
   //
   //   String? imageUrl = await snapshot.ref.getDownloadURL();
   //   String? fullname = fullNameController.text.trim();
   //
   //   widget.userModel.fullName = fullname;
   //   widget.userModel.profilePic = imageUrl;
   //
   //   await FirebaseFirestore.instance.collection("users").doc(widget.userModel.uid).set(widget.userModel.toMap()).then((value) {
   //
   //
   //     print('data uploded to firestore');
   //
   //   });
   // }


   @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Complete Profile'),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.blue,
      centerTitle: true,),

      body: SafeArea(
        child: Container(
          child: ListView(
            children: [

              Text("UserModel:${widget.userModel.email}"),

              CupertinoButton(
                onPressed: (){

                  showPhotoOption();

                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: (imageFile!=null ) ?FileImage(imageFile!):null,

                  child:(imageFile==null)? Icon(Icons.person , size: 40,):null,
                ),
              ),
              Container(
                margin:
                EdgeInsets.only(top: 12, left: 8, right: 12, bottom: 4),
                child: TextField(
                  maxLines: 1,
                  controller: fullNameController,
                  decoration: InputDecoration(
                      fillColor: Colors.black38,
                      hintText: 'Full Name',

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        // Change color as needed
                        borderRadius: BorderRadius.circular(10.0),
                        // Adjust the radius as needed
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        // Change color as needed
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                ),
              ),

              SizedBox(height: 10,),
              Container(
                  constraints: BoxConstraints(maxWidth: 100),
                  margin: EdgeInsets.only(left: 100 , right: 100)
                  ,


                  child:

              ElevatedButton(
                  onPressed: () {



                    checkValues();
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));

                  },
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      )),
                  child: const Text(
                    'Submit',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  )),
              )


            ],
          ),
        ),
      ),
    );
  }





}
