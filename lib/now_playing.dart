import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:music/song_model.dart';

class NowPlaying extends StatefulWidget {
  NowPlaying({this.uri, this.song, this.songmodel});
  final Song song;
  final String uri;
  final SongModel songmodel;
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

enum PlayerState { stopped, playing, paused }

class _NowPlayingState extends State<NowPlaying> {
  
  MusicFinder audioPlayer;
  Duration duration = new Duration();
  Duration position = new Duration();
  PlayerState playerState;
  String title;
  String artist;

  bool playing;

  Widget playIcon = Icon(Icons.pause);
  Widget repeatIcon;
  Widget shuffleIcon;

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

  void playPrevious() {
    audioPlayer.stop();
    widget.songmodel.getPrev();
    _playLocal(widget.songmodel.songs[widget.songmodel.currentSong].uri);
    setState(() {
      title = widget.songmodel.songs[widget.songmodel.currentSong].title;
      artist = widget.songmodel.songs[widget.songmodel.currentSong].title;
    });
  }

  @override
  void initState(){
    super.initState();
    setRepeatIcon();
    setShuffleIcon();
    initPlayer();
  }

  void initPlayer(){
    audioPlayer = new MusicFinder();

    title = widget.songmodel.songs[widget.songmodel.currentSong].title;
    artist = widget.songmodel.songs[widget.songmodel.currentSong].artist;
    // setRepeatIcon();
    // setShuffleIcon();

    audioPlayer.setDurationHandler((d) => setState(() {
      duration = d;
    }));

    audioPlayer.setPositionHandler((p) => setState(() {
        position = p;
    }));

    audioPlayer.setCompletionHandler(() {
      onComplete();
      setState(() {
        position = duration;
      });
    });

    audioPlayer.setErrorHandler((msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    });

    audioPlayer.stop();
    _playLocal(widget.songmodel.songs[widget.songmodel.currentSong].uri);
    widget.songmodel.isPlaying = true;
  }

  void onComplete() {
    audioPlayer.stop();
    if(widget.songmodel.repeatMode == 'OFF' && widget.songmodel.currentSong == widget.songmodel.songs.length-1){
      audioPlayer.stop();
      setState(() {
        widget.songmodel.isPlaying = false;
        position = position = new Duration(seconds:0);
        playIcon = Icon(Icons.play_arrow);
      });        
      return;
    }
    widget.songmodel.getNext();
    _playLocal(widget.songmodel.songs[widget.songmodel.currentSong].uri);
    setState(() {
      title = widget.songmodel.songs[widget.songmodel.currentSong].title;
      artist = widget.songmodel.songs[widget.songmodel.currentSong].artist;
    });
  }

  void setShuffleIcon(){
    if(widget.songmodel.shuffle){
      setState(() {
        shuffleIcon = Icon(Entypo.shuffle, color: Colors.blue);
      });
    } else {
      setState(() {
        shuffleIcon = Icon(Entypo.shuffle);
      });
    }
  }

  void setRepeatIcon(){
    if(widget.songmodel.repeatMode == 'ALL') {
      setState(() {
        repeatIcon = Icon(Icons.repeat, color: Colors.blue);
      });
    } else if (widget.songmodel.repeatMode == 'ONE') {
      setState(() {
        repeatIcon = Icon(Icons.repeat_one, color: Colors.blue);
      });
    } else {
      setState((){
        repeatIcon = Icon(Icons.repeat);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    MaterialCommunityIcons.playlist_music
                  )
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
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
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title.substring(0,20),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    artist,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(getDuration(position.inSeconds).toString().substring(3, 7)),
                  Expanded(
                    child: Slider(
                      activeColor: Colors.red[900],
                      inactiveColor: Colors.grey,
                      value: position.inSeconds.toDouble(),
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      onChanged: (value) {
                        seekToSecond(value);
                        setState(() {
                          position = new Duration(seconds:value.toInt());
                        });
                      },
                    ),
                  ),
                  Text(getDuration(duration.inSeconds).toString().substring(3, 7)),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    widget.songmodel.setRepeatMode();
                    setRepeatIcon();
                  },
                  icon: repeatIcon,
                  iconSize: 20.0,
                ),
                SizedBox(width: 20.0),
                IconButton(
                  onPressed: () => playPrevious(),
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
                    if(widget.songmodel.isPlaying){
                      setState(() {
                        playIcon = Icon(Icons.play_arrow);
                      });
                      pause();
                    } else {
                      setState(() {
                        playIcon = Icon(Icons.pause);
                      });
                      audioPlayer.play(widget.songmodel.songs[widget.songmodel.currentSong].uri);
                    }
                    widget.songmodel.isPlaying = !widget.songmodel.isPlaying;
                  },
                ),
                SizedBox(width: 20.0),
                IconButton(
                  onPressed:() => onComplete(),
                  icon: Icon(Icons.skip_next),
                  iconSize: 30.0,
                ),
                SizedBox(width: 20.0),
                IconButton(
                  onPressed: () {
                    widget.songmodel.setShuffleMode();
                    setShuffleIcon();
                  },
                  icon: shuffleIcon,
                  iconSize: 20.0,
                )
              ],
            ),
          ],
        )
      ),
    );
  }
}