import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'now_playing.dart';
import 'package:music/playlists.dart';
import 'package:music/song_model.dart';
import 'package:music/songs_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static SongModel songmodel;
  MusicFinder audioPlayer;

  String songTitle, songArtist;

  Widget playIcon;

  _getStringFromSharedPref() async {
    final pref = await SharedPreferences.getInstance();
    var songTitle1 = pref.getString('songTitle');
    var songArtist1 = pref.getString('songArtist');
    if(songTitle1 == null && songArtist1 == null) {
      songArtist = '';
      songTitle = '';
    } else {
      songArtist = songArtist1;
      songTitle = songTitle1;      
    }
  }

  setPlayIcon(){
    if(songmodel.isPlaying){
      setState(() {
        playIcon = Icon(MaterialCommunityIcons.pause_circle);
      });
    } else {
      setState(() {
        playIcon = Icon(MaterialCommunityIcons.play_circle, color: Colors.red[900],);        
      });
    }
  }

  static List<Widget> _widgetOptions = <Widget>[
    Container(
      child: SongsList(songmodel: songmodel,),
    ),
    Container(
      child: Playlists(),
    ),
    Container(
    )
  ];

  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = new MusicFinder();
    songmodel = new SongModel();
    setPlayIcon();
    _getStringFromSharedPref();
  }

  // void filterSearchResults(String query) {
  //   List<String> dummySearchList = List<String>();
  //   dummySearchList.addAll(duplicateItems);
  //   if(query.isNotEmpty) {
  //     List<String> dummyListData = List<String>();
  //     dummySearchList.forEach((item) {
  //       if(item.contains(query)) {
  //         dummyListData.add(item);
  //       }
  //     });
  //     setState(() {
  //       items.clear();
  //       items.addAll(dummyListData);
  //     });
  //     return;
  //   } else {
  //     setState(() {
  //       items.clear();
  //       items.addAll(duplicateItems);
  //     });
  //   }
  // }

  playLocal(String uri) async {
    await audioPlayer.play(uri, isLocal: true);
  }

  pause() async {
    await audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        drawer: Drawer(),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: Stack(
            children: <Widget>[
              _widgetOptions.elementAt(_selectedIndex),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NowPlaying(songmodel: songmodel),)),
                child: SlidingUpPanel(
                  panel: Text('Hi'),
                  // panel: NowPlaying(songmodel: songmodel, songArtist: songArtist, songTitle: songTitle),
                  collapsed: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Hello',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                            Text(
                              'Hi',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 100.0,),
                      IconButton(
                        icon: playIcon,
                        onPressed: () {
                          if(songmodel.isPlaying){
                            pause();
                          } else {
                            audioPlayer.play(songmodel.songs[songmodel.currentSong].uri);
                            }
                          songmodel.isPlaying = !songmodel.isPlaying;
                          setPlayIcon();
                          print(songmodel.isPlaying);
                        },
                      ),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  minHeight: 50.0,
                  maxHeight: 1000.0,
                ),
              ),
            ],
          )
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
      ),
    );
  }
}