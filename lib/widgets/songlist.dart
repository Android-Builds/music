import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music/utils/variables.dart';

class SongList extends StatefulWidget {
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  List<SongInfo> songlist = new List<SongInfo>();

  void initState() {
    super.initState();
    setState(() {
      songlist = songs;
    });
    print(songlist[343].albumArtwork);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: songlist.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(songlist[index].title),
          );
        });
  }
}
