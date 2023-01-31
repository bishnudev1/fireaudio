import 'package:fireaudio/screens/audio_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fire Audio',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fire Audio'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: SingleChildScrollView(
            child: AudioScreen(),
          ),
        ),
      )
    );
  }
}
