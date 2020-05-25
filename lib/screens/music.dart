import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:music/albums.dart';
import 'package:music/now_playing.dart';
import 'package:music/playlists.dart';
import 'package:music/song_model.dart';
import 'package:music/songs_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

Route _createRoute(SongModel songModel, bool playSong) => PageRouteBuilder(
  pageBuilder: (context, animation, secondaryAnimation) => 
    NowPlaying(songmodel: songModel, playSong: playSong),
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    var begin = Offset(0.0, 1.0);
    var end = Offset.zero;
    var curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  },
);

class _HomePageState extends State<HomePage> {

  static SongModel songmodel;
  MusicFinder audioPlayer;
  String songTitle, songArtist;
  Widget playIcon;
  var startVerticalDragDetails;
  var updateVerticalDragDetails;

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

  Future _playLocal(String uri) async {
    await audioPlayer.play(uri, isLocal: true);
  }

  Future pause() async {
    await audioPlayer.pause();
  }

  void playPrevious() {
    audioPlayer.stop();
    songmodel.getPrev();
    _playLocal(songmodel.songs[songmodel.currentSong].uri);
    setState(() {
      songTitle = songmodel.songs[songmodel.currentSong].title;
      songArtist = songmodel.songs[songmodel.currentSong].title;
    });
  }

  void onComplete() {
    audioPlayer.stop();
    if(songmodel.repeatMode == 'OFF' && 
    songmodel.currentSong == songmodel.songs.length-1) {
      audioPlayer.stop();
      setState(() {
        songmodel.isPlaying = false;
        playIcon = Icon(MaterialCommunityIcons.play_circle, color: Colors.red[900],);
      });      
      return;
    }
    songmodel.getNext();
    _playLocal(songmodel.songs[songmodel.currentSong].uri);
    setState(() {
      songmodel.isPlaying = true;
      playIcon = Icon(MaterialCommunityIcons.pause_circle);
      songTitle = songmodel.songs[songmodel.currentSong].title;
      songArtist = songmodel.songs[songmodel.currentSong].artist;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    Container(
      child: SongsList(songmodel: songmodel),
    ),
    Container(
      child: Playlists(),
    ),
    Container(
      child: Album(songModel: songmodel),
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

  playLocal(String uri) async {
    await audioPlayer.play(uri, isLocal: true);
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
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(_createRoute(songmodel, false)),
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: Row(
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
                          icon: Icon(MaterialCommunityIcons.skip_previous),
                          onPressed: () => playPrevious(),
                        ),
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
                        IconButton(
                          icon: Icon(MaterialCommunityIcons.skip_next), 
                          onPressed: () => onComplete(),
                        ),
                      ],
                    ),
                  ),
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
//TODO: probably remove next and previous controls