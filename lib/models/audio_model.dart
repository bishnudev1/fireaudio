import 'package:flutter/material.dart';

class Audios {
  List<AudioModel>? audios;

  Audios({this.audios});

  Audios.fromJson(Map<String, dynamic> json) {
    audios = List.from(json['audios'])
        .map((e) => AudioModel.fromMap(e))
        .cast<AudioModel>()
        .toList();
  }
}

class AudioModel {
  String? audioName;
  String? audioUrl;

  AudioModel({this.audioName, this.audioUrl});

  AudioModel.fromMap(Map<String, dynamic> map) {
    audioName = map["audioName"];
    audioUrl = map["audioUrl"];
  }
}

