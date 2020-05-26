import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music/albums.dart';
import 'package:music/playlists.dart';
import 'package:music/songs_list.dart';
import 'package:music/utils/variables.dart';
import 'package:music/widgets/songlist.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  int _selectedIndex = 0;
  // static SongModel songmodel;

  List<Widget> _widgetOptions = <Widget>[
    Container(
      child: SongList(),
    ),
    Container(
      child: Playlists(),
    ),
    Container(
      child: Text('Hello'),
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //top bar color
      statusBarIconBrightness: Brightness.dark, //top bar icons
      systemNavigationBarColor: Colors.black, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
    ));
    return Scaffold(
      appBar: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: TextFormField(
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 40.0),
                          hintText: 'Search ...',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(50.0)),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            title: Text('Songs'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play),
            title: Text('Playlist'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.album),
            title: Text('Albums'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreenAccent[700],
        onTap: _onItemTapped,
      ),
    );
  }
}