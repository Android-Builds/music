import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

class NowPlaying extends StatefulWidget {
  NowPlaying({@required this.song});
  final Song song;
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  
  MusicFinder audioPlayer;
  Duration _duration = new Duration();
  Duration _position = new Duration();

  bool playing;

  Widget playIcon = Icon(Icons.pause);

  Future _playLocal(String uri) async {
    final result = await audioPlayer.play(uri, isLocal: true);
  }

  Future pause() async {
    final result = await audioPlayer.pause();
  }

  void seekToSecond(double second){
    audioPlayer.seek(second);
  }

  @override
  void initState(){
    super.initState();
    audioPlayer = new MusicFinder();
    audioPlayer.durationHandler = (d) => setState(() {
      _duration = d;
    });
    audioPlayer.positionHandler = (p) => setState(() {
      _position = p;
    });
    audioPlayer.stop();
    _playLocal(widget.song.uri);
    playing = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 500.0,
          ),
          Slider(
            value: _position.inSeconds.toDouble(),
            min: 0,
            max: _duration.inSeconds.toDouble(),
            onChanged: (double value) {
              setState(() {
                seekToSecond(value);
                value = value;
              });
            },
          ),
          IconButton(
            icon: playIcon,
            iconSize: 40.0,
            padding: EdgeInsets.all(0), 
            alignment: Alignment.center,
            onPressed: () {  
              if(playing){
                setState(() {
                  playIcon = Icon(Icons.play_arrow);
                });
                pause();
              } else {
                setState(() {
                  playIcon = Icon(Icons.pause);
                });
                audioPlayer.play(widget.song.uri);
              }
              playing = !playing;
            },
          ),
        ],
      )
    );
  }
}