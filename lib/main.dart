import 'package:flutter/material.dart';
import 'package:permission/permission.dart';
import 'package:storage_path/storage_path.dart';

import 'floating_search.dart';

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

  var imagePath;

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> getSongs() async {
     try {
      imagePath = await StoragePath.imagesPath; //contains images path and folder name in json format
    } catch(PlatformException) {
      imagePath = 'Failed to get path';
    }
  }

  @override
  void initState() {
    items.addAll(duplicateItems);
    getSongs();
    _checkPermissions();
    super.initState();
  }

    bool externalStoragePermissionOkay = false;

  _checkPermissions() async {
    var permissions = await Permission.getPermissionsStatus(
      [PermissionName.Storage]);
    var permissionNames = await Permission.requestPermissions(
      [PermissionName.Storage]);
    //Permission.openSettings;
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
    print(imagePath);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: FloatSearchBar.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: ListTile(
                  leading: Text(
                    '${items[index]}',
                    style: TextStyle(
                    ),
                  ),
                ),
              );
            },
            trailing: Icon(Icons.sort),
            drawer: Drawer(
              child: Container(
                color: Theme.of(context).backgroundColor,
              ),
            ),
            onChanged: (String value) {
              filterSearchResults(value);
            },
            onTap: () {},
            decoration: InputDecoration.collapsed(
              fillColor: Theme.of(context).backgroundColor,
              filled: true,
              hintText: "Search...",
            ),
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
