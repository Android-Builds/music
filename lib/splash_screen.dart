import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:lottie_flutter/lottie_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

// void main() {
//   runApp( MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       title: 'Lottie Animation',
//       theme:  ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const LottieDemo(),
//     );
//   }
// }

class LottieDemo extends StatefulWidget {
  const LottieDemo({Key key}) : super(key: key);

  @override
  _LottieDemoState createState() =>  _LottieDemoState();
}

class _LottieDemoState extends State<LottieDemo>
    with SingleTickerProviderStateMixin {

  LottieComposition _composition;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =  AnimationController(
      duration: const Duration(milliseconds: 1),
      vsync: this,
    );
    loadAsset("assets/opening.json").then((LottieComposition composition) {
      setState(() {
        _composition = composition;
        _controller.forward();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body:  Center(
          child: Lottie(
            composition: _composition,
            size: const Size(300.0, 300.0),
          ),
        ),
      ),
    );
  }
}

Future<LottieComposition> loadAsset(String assetName) async {
  return await rootBundle
      .loadString(assetName)
      .then<Map<String, dynamic>>((String data) => json.decode(data))
      .then((Map<String, dynamic> map) =>  LottieComposition.fromMap(map));
}