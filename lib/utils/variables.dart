import 'dart:async';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music/model/song.dart';
import 'package:music/song_model.dart';

SongModel songModel2;
//List<Song> songs = new List<Song>();
Future<List<SongInfo>> songs;
List<SongInfo> musics = new List<SongInfo>();
List<Song> savedsongs = new List<Song>();
bool disco = false;
bool disco2 = false;
StreamController<bool> discoController;
StreamController<bool> discoController2;