import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:music/song_model.dart';

class Album extends StatefulWidget {
  Album({this.songModel});
  final SongModel songModel;
  @override
  _AlbumState createState() => _AlbumState();
}

class _AlbumState extends State<Album> {

  Widget _buildGroupSeparator(dynamic groupByValue) {
    return Text('$groupByValue');
  }

  MusicFinder audioPlayer;
  var map2;

  @override
  void initState() {
    super.initState();
    initAlbums();
  }

  Future<void> initAlbums() async {
    audioPlayer = new MusicFinder();
    // await MusicFinder.allSongs();
    setState(() {
     widget.songModel.albums = Map.fromIterable(widget.songModel.songs, 
              key: (element) => element.album, value: (element) => element.title);
      // map2 = {};
      // widget.songModel.songs.forEach((element) => map2[element.album] = element.title);
      // print(map2);
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



      // child:   GroupedListView(
      //   elements: widget.songModel.songs,
      //   groupBy: (element) => element.album,
      //   groupSeparatorBuilder: _buildGroupSeparator,
      //   separator: Divider(
      //       color: Colors.red,
      //     ),
      //   itemBuilder: (context, element) {
      //     return Container(
      //       child: Column(
      //         children: <Widget>[
      //           Text(element.title + ' album: ' + element.album,
      //           textAlign: TextAlign.start,
      //           ),
      //         ],
      //       ),
      //     );
      //   } ,
      // ),
    // );
  }
}