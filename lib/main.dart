import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:music/now_playing.dart';
import 'package:music/settings.dart';
import 'package:music/songs_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey,
        )
      ),
      darkTheme: ThemeData(
        primaryTextTheme: TextTheme(
          title: TextStyle(
            color: Colors.grey,
          )
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
      ),
      home: MyHomePage(title: 'Music'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final duplicateItems = List<String>.generate(100, (i) => "Item $i");
  var items = List<String>();

  // static List<Song> _songs = [];

  static List<Widget> _widgetOptions = <Widget>[
    Container(
      child: SongsList(),
    ),
    Container(
      child: Text(
        'HI',
        style: TextStyle(
          color: Colors.white
        ),
      ),
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    items.addAll(duplicateItems);
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if(item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: <Widget>[
              Flexible(child: _widgetOptions.elementAt(_selectedIndex)),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NowPlaying())),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 100),
                        Text('Hi'),
                        SizedBox(width: 240),
                        IconButton(
                          onPressed: (){},
                          icon: Icon(Feather.play_circle)
                        )
                      ],
                    ),
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50.0),
                        topLeft: Radius.circular(50.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: Theme.of(context).backgroundColor,
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.album),
              title: Text('Albums'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_play),
              title: Text('Playlist'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              title: Text('Songs'),
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

getColor(BuildContext context) {
  var brightness = MediaQuery.of(context).platformBrightness;
  if (brightness == Brightness.dark)
    return Colors.white;
  else
    return Colors.black;
}