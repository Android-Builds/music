import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/now_playing.dart';

class SongsList extends StatefulWidget {
  @override
  _SongsListState createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {

  List<Song> _songs;
  MusicFinder audioPlayer;

  @override
  void initState(){
    super.initState();
    initSongs();
  }

  Future<void> initSongs() async {
    audioPlayer = new MusicFinder();
    var songs;
    try {
      songs = await MusicFinder.allSongs();
    } catch (e) {
      print("Failed to get songs: '${e.message}'.");
    }
    setState(() {
      _songs = songs;
    });
  }

  Future _playLocal(String uri) async {
    final result = await audioPlayer.play(uri, isLocal: true);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: getSongs(_songs),
    );
  }

  getSongs(List<Song> songs){
    if (songs == null){
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(songs.length.toString() + ' songs found'),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: songs.length,
                itemBuilder: (context, index){
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
                    leading: CircleAvatar(
                      child: Text(songs[index].title[0]),
                    ),
                    title: Text(songs[index].title),
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => NowPlaying(
                        song: songs[index],
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      );
    }
  }

}