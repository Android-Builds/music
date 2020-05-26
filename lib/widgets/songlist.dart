import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:lottie/lottie.dart';
import 'package:music/utils/variables.dart';

class SongList extends StatefulWidget {
  @override
  _SongListState createState() => _SongListState();
}

StreamSubscription periodicSub;
StreamSubscription periodicSub2;

class _SongListState extends State<SongList> {
  List<SongInfo> songlist = new List<SongInfo>();
  int r, g, b;
  int r1, b1, g1;
  double o;

  getColors() {
    r = r1 = Random().nextInt(255);
    g = g1 = Random().nextInt(255);
    b = b1 = Random().nextInt(255);
    o = Random().nextDouble();
  }

  void initState() {
    super.initState();
    getColors();
    discoController = new StreamController();
    discoController2 = new StreamController();
    discoController.stream.listen((event) {
      setState(() {
        if (event) {
          updateParams();
          randomcol = false;
        } else {
          periodicSub.cancel();
        }
      });
    });
    discoController2.stream.listen((event) {
      setState(() {
        if (event) {
          updateParams2();
          randomcol = true;
        } else {
          periodicSub2.cancel();
        }
      });
    });
  }

  updateParams() {
    periodicSub =
        new Stream.periodic(const Duration(milliseconds: 500)).listen((_) {
      setState(() {
        r = Random().nextInt(255);
        g = Random().nextInt(255);
        b = Random().nextInt(255);
        o = Random().nextDouble();
      });
    });
  }

  updateParams2() {
    periodicSub2 =
        new Stream.periodic(const Duration(milliseconds: 500)).listen((_) {
      setState(() {
        // r1 = Random().nextInt(255);
        // b1 = Random().nextInt(255);
        // g1 = Random().nextInt(255);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: songs,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  if (disco2 || randomcol) {
                    r = Random().nextInt(255);
                    g = Random().nextInt(255);
                    b = Random().nextInt(255);
                  }
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color.fromRGBO(r, g, b, o),
                      foregroundColor:
                          MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark
                              ? Colors.black
                              : Colors.white,
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
