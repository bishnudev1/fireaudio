import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/audio_model.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {

  late AudioPlayer _player;
  
  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final firestore = FirebaseFirestore.instance
      .collection('Fire-Audio')
      .doc('Eb8CqCMmjTrOqWk9Zn17')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
          final Audios data =
              Audios.fromJson(snapshot.data!.data()! as Map<String, dynamic>);
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.audios!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Align(
                  //alignment: Alignment.center,
                  child: Container(
                    //padding: EdgeInsets.symmetric(vertical: 20),
                    height: 80,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurple),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              index.toString(),
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              data.audios![index].audioName.toString(),
                              style: TextStyle(color: Colors.white, fontSize: 13,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        IconButton(onPressed: () async{
                          String url = data.audios![index].audioUrl.toString();
                          log(url);
                          await _player.play(UrlSource(url));
                        }, icon: Icon(Icons.play_circle,color: Colors.white,size: 26,)),
                        IconButton(onPressed: (){
                          _player.pause();
                        }, icon: Icon(Icons.pause_circle,color: Colors.white,size: 26,)),
                        IconButton(onPressed: (){
                          _player.resume();
                        }, icon: Icon(Icons.queue_play_next,color: Colors.white,size: 26,)),
                        IconButton(onPressed: (){
                          _player.stop();
                        }, icon: Icon(Icons.stop,color: Colors.white,size: 26,)),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
