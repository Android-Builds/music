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
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: songs,
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data.length + 1,
                  itemBuilder: (context, index) {
                    if (disco2 || randomcol) {
                      r = Random().nextInt(255);
                      g = Random().nextInt(255);
                      b = Random().nextInt(255);
                    }
                    if (index == 0) {
                      return Container(
                        padding: EdgeInsets.only(left: 30.0, top: 40.0),
                        height: 120.0,
                        child: Row(
                          children: [
                            Text(
                              'All Songs',
                              style: TextStyle(
                                  fontSize: 35.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                disco = !disco;
                                setState(() {
                                  if (disco) {
                                    updateParams();
                                    randomcol = false;
                                  } else {
                                    periodicSub.cancel();
                                  }
                                });
                              },
                              icon: Icon(Icons.lightbulb_outline),
                            ),
                            IconButton(
                              onPressed: () {
                                disco2 = !disco2;
                                setState(() {
                                  if (disco2) {
                                    updateParams2();
                                    randomcol = true;
                                  } else {
                                    periodicSub2.cancel();
                                  }
                                });
                              },
                              icon: Icon(Icons.disc_full),
                            )
                          ],
                        ),
                      );
                    } else {
                      Color color = Color.fromRGBO(r, g, b, o > 0.7 ? 0.7 : o);
                      if (darkmode && color.computeLuminance() < 0.5) {
                        color = Color.fromRGBO(r, g, b, 0.7);
                      }
                      return ListTile(
                        focusColor: Colors.blueAccent,
                        hoverColor: Colors.blueAccent,
                        leading: CircleAvatar(
                          backgroundColor: color,
                          child: snapshot.data[index].albumArtwork != null
                              ? Image.file(
                                  snapshot.data[index - 1].albumArtwork)
                              : Icon(Icons.music_note),
                        ),
                        title: Text(snapshot.data[index - 1].title),
                      );
                    }
                  },
                ),
              );
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
          },
        ),
        Positioned(
          right: 20,
          top: 60,
          child: FloatingActionButton(
            onPressed: () {},
            mini: true,
            backgroundColor: Color.fromRGBO(r, g, b, o > 0.8 ? 0 : 0.9),
            child: Icon(
              Icons.search,
              size: 20.0,
            ),
          ),
        )
      ],
    );
  }
}
