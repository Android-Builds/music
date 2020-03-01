import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:music/constants.dart';
import 'package:music/music.dart';

void main() {
  runApp( MyApp());
}

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
        ),
        backgroundColor: Colors.black,
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
   @override
   void initState(){
     super.initState();
     Timer(Duration(seconds: 2), () {
      Route route = MaterialPageRoute(builder: (context) => HomePage());
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
                    'Orchid Music',
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