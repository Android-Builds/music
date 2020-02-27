import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:music/settings.dart';
import 'dart:io';
import 'package:music/now_playing.dart';
import 'package:music/song_model.dart';
import 'package:quiver/strings.dart';

class SongsList extends StatefulWidget {
  SongsList({this.songmodel});
  final songModel songmodel;
  @override
  _SongsListState createState() => _SongsListState();
}

enum MenuOptions { addtoPlaylist, playNext, addToQueue, goToAlbum }

class _SongsListState extends State<SongsList> {

  List<Song> _songs;
  List<Song> duplicateSongs;
  MusicFinder audioPlayer;
  //songModel songmodel;

  @override
  void initState(){
    super.initState();
    //songmodel = new songModel();
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
    duplicateSongs = songs;
    setState(() {
     widget.songmodel.duplicateSongs = songs;
    });
  }

  void filterSearchResults(String query) {
    List<Song> dummySearchList = List<Song>();
    dummySearchList = duplicateSongs;
    if(query.isNotEmpty) {
      List<Song> dummyListData = List<Song>();
      for(int i=0;i<duplicateSongs.length;i++){
        if(equalsIgnoreCase(query, dummySearchList[i].title)){
          dummyListData.add(dummySearchList[i]);
        }
          setState(() {
            _songs.clear();
            _songs = dummyListData;
          });
      }
        } else {
          setState(() {
            _songs.clear();
            _songs.addAll(duplicateSongs);
          });
        }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: getSongs(widget.songmodel.duplicateSongs),
    );
  }

  getSongs(List<Song> songs){
    if (songs.length == null){
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return FloatingSearchBar.builder(
        itemCount: songs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            leading: CircleAvatar(
              child: songs[index].albumArt != null ? Image.file(File(songs[index].albumArt)): Icon(Icons.music_note),
            ),
            title: Text(songs[index].title),
            onTap: () {
              widget.songmodel.currentSong = index;
              Navigator.push(context, MaterialPageRoute(
              builder: (context) => NowPlaying(
                songmodel: widget.songmodel,
                ),
              )
            );
            },
            trailing: PopupMenuButton<MenuOptions>(
              onSelected: (MenuOptions result) { setState(() { /*_selection = result;*/ }); },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOptions>>[
                const PopupMenuItem<MenuOptions>(
                  value: MenuOptions.addtoPlaylist,
                  child: Text('Add to Playlist'),
                ),
                const PopupMenuItem<MenuOptions>(
                  value: MenuOptions.playNext,
                  child: Text('Play Next'),
                ),
                const PopupMenuItem<MenuOptions>(
                  value: MenuOptions.addToQueue,
                  child: Text('Add to queue'),
                ),
                const PopupMenuItem<MenuOptions>(
                  value: MenuOptions.goToAlbum,
                  child: Text('Go to album'),
                ),
              ],
            ),
          );
        },
      trailing: CircleAvatar(
        child: Text("RD"),
      ),
        drawer: Drawer(
          elevation: 0.0,
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: ListView(
              children: <Widget>[
                Container(
                  height: 150.0,
                  child: DrawerHeader(
                    child: Text(
                      'Walls',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                  },
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                      color: getColor(context),
                    ),
                    ),
                  trailing: Icon(
                    Icons.settings,
                    color: getColor(context),
                    ),
                ),
              ],
            ),
          ),
        ),
      onChanged: (String value) {
        filterSearchResults(value);
      },
      onTap: () {},
      decoration: InputDecoration.collapsed(
        hintText: "Search...",
      ),
      );
    }
  }

  getColor(BuildContext context) {
  var brightness = MediaQuery.of(context).platformBrightness;
  if (brightness == Brightness.dark)
    return Colors.white;
  else
    return Colors.black;
}

}