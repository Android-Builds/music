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
    // return FutureBuilder(
    //   future: songs,
    //   builder: (_, snapshot) {
    //     if (snapshot.hasData) {
    //       return CustomScrollView(
    //         slivers: [
    //           SliverAppBar(
    //             expandedHeight: 100.0,
    //             flexibleSpace: const FlexibleSpaceBar(
    //               title: Text('SliverAppBar Sample'),
    //             ),
    //             actions: <Widget>[
    //               IconButton(
    //                 icon: const Icon(Icons.add_circle),
    //                 tooltip: 'Add new entry',
    //                 onPressed: () {/* ... */},
    //               ),
    //             ],
    //           ),
    //           SliverList(
    //             delegate: SliverChildBuilderDelegate(
    //               (context, index) {
    //                 if (disco2 || randomcol) {
    //                   r = Random().nextInt(255);
    //                   g = Random().nextInt(255);
    //                   b = Random().nextInt(255);
    //                 }
    //                 return ListTile(
    //                   leading: CircleAvatar(
    //                     backgroundColor: Color.fromRGBO(r, g, b, o),
    //                     foregroundColor:
    //                         MediaQuery.of(context).platformBrightness ==
    //                                 Brightness.dark
    //                             ? Colors.black
    //                             : Colors.white,
    //                     child: snapshot.data[index].albumArtwork != null
    //                         ? Image.file(snapshot.data[index].albumArtwork)
    //                         : Icon(Icons.music_note),
    //                   ),
    //                   title: Text(snapshot.data[index].title),
    //                 );
    //               },
    //               // Or, uncomment the following line:
    //               childCount: snapshot.data.length,
    //             ),
    //           ),
    //         ],
    //       );
    //     } else {
    //       return Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             LottieBuilder.asset(

    //               'assets/loading.json',
    //               height: 200.0,
    //             ),
    //             SizedBox(height: 20.0),
    //             Text('Loading media, please wait ...')
    //           ],
    //         ),
    //       );
    //     }
    //   },
    // );

    return Stack(
      children: [
        FutureBuilder(
          future: songs,
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
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
                      child: Text(
                        'All Songs',
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    );
                  } else {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromRGBO(r, g, b, o),
                        foregroundColor:
                            MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? Colors.black
                                : Colors.white,
                        child: snapshot.data[index].albumArtwork != null
                            ? Image.file(snapshot.data[index - 1].albumArtwork)
                            : Icon(Icons.music_note),
                      ),
                      title: Text(snapshot.data[index - 1].title),
                    );
                  }
                },
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
