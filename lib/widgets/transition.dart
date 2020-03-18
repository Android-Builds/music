import 'package:flutter/material.dart';
import 'package:music/now_playing.dart';

import '../song_model.dart';

Route _createRoute(SongModel songModel, bool playSong) => PageRouteBuilder(
  pageBuilder: (context, animation, secondaryAnimation) => NowPlaying(songmodel: songModel, playSong: playSong),
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    var begin = Offset(0.0, 1.0);
    var end = Offset.zero;
    var curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  },
);