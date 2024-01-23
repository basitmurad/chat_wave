import 'package:chat_wave/models/firebaseHelper.dart';
import 'package:chat_wave/models/usersModels.dart';
import 'package:chat_wave/screens/dashboard.dart';
import 'package:chat_wave/screens/siginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAniQZGhRa-H5W0NXt0DR-gAtQISQ678-E",
            // paste your api key here
            appId: "1:402799005924:android:586407ae69bb1f8bc4dcf1",
            //paste your app id here
            messagingSenderId: "402799005924",
            //paste your messagingSenderId here
            projectId: "wave-50694",
            storageBucket:
                "wave-50694.appspot.com")); //paste your project id here
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    UserModel? userModel = await FirebaseHelper.getUserModel(currentUser.uid);

    if (userModel != null) {
      runApp(MyAppLogin(userModel: userModel, firebaeUser: currentUser));

      print('user model $userModel  and current user is $currentUser');
      return;
    }
  }

  runApp(MyApp());
  print('Not register user is null');

}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignIn(),
    );
  }
}

class MyAppLogin extends StatelessWidget {
  final UserModel userModel;
  final User firebaeUser;

  const MyAppLogin(
      {super.key, required this.userModel, required this.firebaeUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(
        userModel: userModel,
        firebaseUser: firebaeUser,
      ),
    );
  }
}
