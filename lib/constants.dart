import 'package:flutter/material.dart';

getColor(BuildContext context) {
  var brightness = MediaQuery.of(context).platformBrightness;
  if (brightness == Brightness.dark)
    return Colors.white;
  else
    return Colors.black;
}

  String songDuration = '0:00';

  double sliderDuration = 0.0;
  String songPosition = '0:00';
  Duration sliderPosition = new Duration(seconds: 0);