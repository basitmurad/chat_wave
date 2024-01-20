import 'package:chat_wave/screens/siginScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main()  async{
WidgetsFlutterBinding.ensureInitialized();
try {
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAniQZGhRa-H5W0NXt0DR-gAtQISQ678-E", // paste your api key here
          appId: "1:402799005924:android:586407ae69bb1f8bc4dcf1", //paste your app id here
          messagingSenderId: "402799005924", //paste your messagingSenderId here
          projectId: "wave-50694",
      ));//paste your project id here

          } catch (e) {
  print('Error initializing Firebase: $e');
}

  runApp(MyApp());
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
