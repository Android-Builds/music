import 'package:flutter/material.dart';
import 'package:music/reusable_card.dart';

class Playlists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 200.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        width: 160.0,
                        child: Expanded(
                          child: ReusableCard(colour: Colors.black),
                        ),
                      ),
                      Container(
                        width: 160.0,
                        child: Expanded(
                          child: ReusableCard(colour: Colors.black),
                        ),
                      ),
                      Container(
                        width: 160.0,
                        child: Expanded(
                          child: ReusableCard(colour: Colors.black),
                        ),
                      ),
                      Container(
                        width: 160.0,
                        child: Expanded(
                          child: ReusableCard(colour: Colors.black),
                        ),
                      ),
                      Container(
                        width: 160.0,
                        child: Expanded(
                          child: ReusableCard(colour: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200.0,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: ReusableCard(colour: Colors.black)),
                      Expanded(child: ReusableCard(colour: Colors.black)),
                    ],
                  ),
                ),
                Container(
                  height: 200.0,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: ReusableCard(colour: Colors.black)),
                      Expanded(child: ReusableCard(colour: Colors.black)),
                    ],
                  ),
                ),
                Container(
                  height: 200.0,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: ReusableCard(colour: Colors.black)),
                      Expanded(child: ReusableCard(colour: Colors.black)),
                    ],
                  ),
                ),                
              ],
            ),
          ),
        );
      },
    );
  }
}