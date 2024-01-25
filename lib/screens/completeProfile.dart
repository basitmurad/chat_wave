import 'dart:io';
import 'package:chat_wave/models/usersModels.dart';
import 'package:chat_wave/screens/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:progress_dialog2/progress_dialog2.dart';

class CompleteProfile extends StatefulWidget {
  // const CompleteProfile({Key? key}) : super(key: key);


  final UserModel userModel;
  final User firebaseUser;

  const CompleteProfile({super.key, required this.userModel,  required this.firebaseUser});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();


}

class _CompleteProfileState extends State<CompleteProfile> {


  File? imageFile;
  TextEditingController fullNameController = TextEditingController();
  ProgressDialog? _progressDialog;

  @override
  void initState() {
    super.initState();
    // Initialize _progressDialog in initState
    _progressDialog = ProgressDialog(context);
  }

  void showProgress() {
    _progressDialog!.show();
  }

  void hideProgress() {
    if (mounted) {
      _progressDialog?.hide();
    }  }

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




  void selectImage(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void showPhotoOption() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text('Upload Profile Picture'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                Navigator.pop(context);
                selectImage(ImageSource.gallery);
              },
              leading: Icon(Icons.photo_album),
              title: const Text('Select from gallery'),
            ),
            ListTile(
              onTap: () {
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
  Future<String?> uploadImageToStorage(File imageFile, String fileName) async {

    showProgress();
    try {
      if (_progressDialog == null) {
        // Ensure _progressDialog is initialized
        _progressDialog = ProgressDialog(context);
      }


      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
      storage.ref().child('profile_images').child(widget.userModel.uid!.toString());

      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      String? imageUrl = downloadUrl?.toString();
      String? fullName = fullNameController.text.toString();

      widget.userModel.fullName = fullName;
      widget.userModel.profilePic = imageUrl;

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.userModel.uid)
          .set(widget.userModel.toMap())
          .then((value) {
        hideProgress();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Dashboard(userModel: widget.userModel, firebaseUser: widget.firebaseUser)));
        print('Data uploaded to Firestore');
      });

      return imageUrl;
    } catch (e) {
      hideProgress();
      print("Error uploading image: $e");
      return null;
    }
  }

  void checkValues() async {
    String fullname = fullNameController.text.trim();

    if (fullname == "" || imageFile == null) {
      print("Please fill all the fields");
      showToast("Please fill all the fields");
    } else {
      Logger li = Logger();
      li.d('Uploading data');

      // Upload the image to Firebase Storage
      String? imageUrl = await uploadImageToStorage(imageFile!, 'example.jpg');

      if (imageUrl != null) {
        // Now you can use imageUrl for further processing
        print('Image uploaded. Download URL: $imageUrl');

        // Add your code to save other user data and imageUrl to Firebase or any other storage
      } else {
        print('Error uploading image.');
      }
    }
  }




  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(title: Text('Complete Profile', style: (TextStyle(color: Colors.white, fontSize: 18)),),
        automaticallyImplyLeading: false,

        backgroundColor: Color(0xFF4DC681),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Container(
          child: ListView(
            children: [

              // Text("UserModel:${widget.userModel.email}"),
              // Text("UserModel:${widget.userModel.uid}"),

              CupertinoButton(
                onPressed: () {
                  showPhotoOption();
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: (imageFile != null)
                      ? FileImage(imageFile!)
                      : null,

                  child: (imageFile == null)
                      ? Icon(Icons.person, size: 40,)
                      : null,
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
                        borderSide: BorderSide(color: Color(0xFF4DC681)),
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
                margin: EdgeInsets.only(left: 100, right: 100)
                ,


                child:

                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        checkValues();
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));

                      },
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Color(0xFF4DC681)),
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
                ),
              )


            ],
          ),
        ),
      ),
    );
  }


}


