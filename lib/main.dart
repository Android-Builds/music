import 'dart:async';
import 'dart:ui';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:music/constants.dart';
import 'package:music/screens/homepage.dart';
import 'package:music/utils/variables.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: Colors.indigo,
        iconTheme: IconThemeData(
          color: Colors.grey,
        )
      ),
      darkTheme: ThemeData(
        backgroundColor: Colors.black,
        primarySwatch: Colors.indigo,
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
 class SplashScreen extends StatefulWidget {
   @override
   _SplashScreenState createState() => _SplashScreenState();
 }
 
 class _SplashScreenState extends State<SplashScreen> {

   final FlutterAudioQuery audioQuery = FlutterAudioQuery();

   fetchSongs() async {
     //songs = await MusicFinder.allSongs();
     songs = await audioQuery.getSongs();
   }

   @override
   void initState(){
     super.initState();
    //  songModel2 = new SongModel();
     fetchSongs();
     Timer(Duration(seconds: 2), () {
      Route route = MaterialPageRoute(builder: (context) => HomePage2());
      Navigator.pushReplacement(context, route);
    });
  }
   
   @override
   Widget build(BuildContext context) {
     return SafeArea(
       child: Scaffold(
         body: Stack(
           fit: StackFit.expand,
           children: <Widget>[
             Container(
               decoration: BoxDecoration(
                 color: Theme.of(context).backgroundColor,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Music',
                    style: TextStyle(
                      color:getColor(context),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ShadowsIntoLight',
                      letterSpacing: 3.0
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Icon(
                    Feather.music,
                    size: 40.0,
                  )
                ],
              ),
            ],
         ),
       ),
     );
   }
 }