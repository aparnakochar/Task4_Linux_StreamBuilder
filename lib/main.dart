import 'package:fb_task/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}


/*
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_task/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:fb_task/rounded_button.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

/*
mene kiya hai battery saver mode on okok hmm oye  tum lunch karo jaake 
*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}



*/
