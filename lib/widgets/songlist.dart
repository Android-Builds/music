import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:lottie/lottie.dart';
import 'package:music/model/song.dart';
import 'package:music/utils/variables.dart';

class SongList extends StatefulWidget {
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  List<SongInfo> songlist = new List<SongInfo>();

  void initState() {
    super.initState();
    // setState(() {
    //   songlist = songs;
    // });
    // Timer(Duration(seconds: 20), () {
    //   songlist.forEach((element) {
    //     if (element.isMusic) {
    //       if (!musics.contains(element)) {
    //         musics.add(element);
    //       }
    //     }
    //     // if(element.isMusic) {
    //     //   savedsongs.add(new Song(
    //     //     album: element.album,
    //     //     albumArtwork: element.albumArtwork,
    //     //     albumID: element.albumId,
    //     //     artist: element.albumId,
    //     //     artistID: element.artistId,
    //     //     duration: element.duration,
    //     //     bookmark: element.bookmark,
    //     //     filePath: element.filePath,
    //     //     fileSize: element.fileSize,
    //     //     year: element.year,
    //     //     composer: element.composer,
    //     //     track: element.track,
    //     //     title: element.title
    //     //   ));
    //     // }
    //   });
    // });
    // Timer(Duration(seconds: 1), () {
    //   //print(savedsongs.length);
    //   print(musics.length);
    //   // print(songs.length);
    // });
  }

  @override
  Widget build(BuildContext context) {
    int r = Random().nextInt(255);
    int g = Random().nextInt(255);
    int b = Random().nextInt(255);
    return FutureBuilder(
        future: songs,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color.fromRGBO(r, g, b, 1),
                      child: snapshot.data[index].albumArtwork != null
                          ? Image.file(snapshot.data[index].albumArtwork)
                          : Icon(Icons.music_note),
                    ),
                    title: Text(snapshot.data[index].title),
                  );
                });
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset(
                    'assets/loading.json',
                    height: 200.0,
                  ),
                  SizedBox(height: 20.0),
                  Text('Loading media, please wait ...')
                ],
              ),
            );
          }
        });
  }
}
