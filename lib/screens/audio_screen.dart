import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/audio_model.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {


  final firestore = FirebaseFirestore.instance
    .collection('Fire-Audio')
    .doc('Eb8CqCMmjTrOqWk9Zn17')
    .snapshots();

  //List<String> items = ["Hello","Hi","Greet","Namaste"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: firestore,
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          } else {
            final Audios data = Audios.fromJson(
                snapshot.data!.data() as Map<String, dynamic>);
            return ListView.builder(
              itemCount: data.audios!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(index.toString()),
                  subtitle: Text(data.audios![index].audioName.toString()),
                );
              },
            );
          }
        },
      ),
    );
  }
}
