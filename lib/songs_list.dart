import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:music/now_playing.dart';
import 'package:music/song_model.dart';
import 'package:quiver/strings.dart';

class SongsList extends StatefulWidget {
  SongsList({this.songmodel});
  final SongModel songmodel;
  @override
  _SongsListState createState() => _SongsListState();
}

enum MenuOptions { addtoPlaylist, playNext, addToQueue, goToAlbum }

class _SongsListState extends State<SongsList> {

  List<Song> _songs;
  List<Song> duplicateSongs;
  MusicFinder audioPlayer;

  @override
  void initState(){
    super.initState();
    initSongs();
  }

  Future<void> initSongs() async {
    audioPlayer = new MusicFinder();
    await MusicFinder.allSongs();
    setState(() {
     widget.songmodel.duplicateSongs = widget.songmodel.songs;
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

  popUpMenuActions(MenuOptions result, int index){
    switch(result){
      case MenuOptions.addtoPlaylist:
        widget.songmodel.playQueue.add(widget.songmodel.songs[index]);
        break;
      case MenuOptions.playNext:
        widget.songmodel.currentSong = index;
        break;
      case MenuOptions.addToQueue:
        widget.songmodel.playQueue.add(widget.songmodel.songs[index]);
        break;
      case MenuOptions.goToAlbum:
        // TODO: Handle this case.
        break;
    }
  }

  _showPopupMenu(Offset offset) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(left, top, 0, 0),
    elevation: 8.0,
  );
}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: getSongs(widget.songmodel.duplicateSongs),
    );
  }

  getSongs(List<Song> songList){
    if (songList.length == null){
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            floating: true,
            flexibleSpace: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Stack(
                          children: <Widget>[
                            IconButton(
                              onPressed: () => Scaffold.of(context).openDrawer(),
                              icon: Icon(Icons.drag_handle),
                            ),
                            TextField(
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                              textAlignVertical: TextAlignVertical.bottom,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.blue, width: 0.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.grey, width: 0.5),
                                ),
                                hintText: 'Search..',
                              ),
                            ),
                            Positioned(
                              right: 15.0, top: 12.0,
                              child: GestureDetector(
                                onTapDown: (TapDownDetails details) {
                                  _showPopupMenu(details.globalPosition);
                                },
                                child: Icon(Icons.sort),
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            expandedHeight: 70,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
                  leading: CircleAvatar(
                    child: songList[index].albumArt != null ? 
                            Image.file(File(songList[index].albumArt)): 
                              Icon(Icons.music_note),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(songList[index].title.length >=20 ? 
                              songList[index].title.substring(0,20) + '...' 
                                : songList[index].title + '...'),
                      Text(songList[index].duration.toString()),
                    ],
                  ),
                  subtitle: Text(songList[index].artist.length >=20 ? 
                              songList[index].artist.substring(0,20) + '...' 
                                : songList[index].artist + '...',
                        style: TextStyle(fontSize: 12.0),),
                  onTap: () {
                    widget.songmodel.currentSong = index;
                    Navigator.push(context, MaterialPageRoute(
                    builder: (context) => NowPlaying(
                      songmodel: widget.songmodel,
                      playSong: true,
                      ),
                    )
                  );
                  },
                  trailing: PopupMenuButton<MenuOptions>(
                    onSelected: (MenuOptions result) { 
                      setState(() { 
                        popUpMenuActions(result, index); 
                      }); 
                    },
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
              childCount: songList.length,
            ),
          ),
        ],
      );
    }
  }

  //       onChanged: (String value) {
  //         filterSearchResults(value);
  //       },
  //       onTap: () {},
  //       decoration: InputDecoration.collapsed(
  //         hintText: "Search...",
  //       ),
  //       ),
  //     );
  // }
}