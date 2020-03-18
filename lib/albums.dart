import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:music/song_model.dart';

class Album extends StatefulWidget {
  Album({this.songModel});
  final SongModel songModel;
  @override
  _AlbumState createState() => _AlbumState();
}

class _AlbumState extends State<Album> {

  MusicFinder audioPlayer;
  var map2;

  @override
  void initState() {
    super.initState();
    initAlbums();
  }

  Future<void> initAlbums() async {
    audioPlayer = new MusicFinder();
    setState(() {
     widget.songModel.albums = Map.fromIterable(widget.songModel.songs, 
              key: (element) => element.album, value: (element) => element.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.songModel.albums);
    return Container(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: widget.songModel.albums.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            child: Center(child: Text(widget.songModel.albums[index]['Music']['title']),
          )
          );
        }
      )
    );
  }
}