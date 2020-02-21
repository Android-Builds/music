import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class NowPlaying extends StatefulWidget {
  NowPlaying({this.uri, this.song});
  final Song song;
  final String uri;
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

  getDuration(int seconds){
    Duration duration = new Duration(seconds: seconds);
    return duration;
  }

  @override
  void initState(){
    super.initState();
    initPlayer();
  }

  void initPlayer(){
    audioPlayer = new MusicFinder();
    audioPlayer.durationHandler = (d) => setState(() {
      _duration = d;
    });
    audioPlayer.positionHandler = (p) => setState(() {
      _position = p;
    });
    audioPlayer.stop();
    if(widget.song != null){
      _playLocal(widget.song.uri);
    } else {
      audioPlayer.play(widget.uri);
    }
    
    playing = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Container(
              height: 250.0,
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 50.0),
          Column(
            children: <Widget>[
              Text(
                widget.song.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(getDuration(_position.inSeconds).toString().substring(3, 7)),
              SizedBox(width: 320.0),
              Text(getDuration(_duration.inSeconds).toString().substring(3, 7)),
            ],
          ),
          Slider(
            value: _position.inSeconds.toDouble(),
            min: 0,
            max: _duration.inSeconds.toDouble(),
            onChangeEnd: (value) {
              setState(() {
                seekToSecond(value);
                value = value;
              });
            },
            onChanged: (value) {
              setState(() {
                seekToSecond(value);
                value = value;
              });
            },
          ),
          SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Feather.repeat),
                iconSize: 20.0,
              ),
              SizedBox(width: 20.0),
              IconButton(
                icon: Icon(Icons.skip_previous),
                iconSize: 30.0,
              ),
              SizedBox(width: 20.0),
              IconButton(
                icon: playIcon,
                iconSize: 30.0,
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
              SizedBox(width: 20.0),
              IconButton(
                icon: Icon(Icons.skip_next),
                iconSize: 30.0,
              ),
              SizedBox(width: 20.0),
              IconButton(
                icon: Icon(Entypo.shuffle),
                iconSize: 20.0,
              )
            ],
          ),
        ],
      )
    );
  }
}