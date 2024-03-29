// import 'package:flute_music_player/flute_music_player.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:music/now_playing.dart';
// import 'package:music/song_model.dart';
// import 'package:music/utils/variables.dart';
// import 'package:quiver/strings.dart';

// class SongsList extends StatefulWidget {
//   SongsList({this.songmodel});
//   final SongModel songmodel;
//   @override
//   _SongsListState createState() => _SongsListState();
// }

// enum MenuOptions { addtoPlaylist, playNext, addToQueue, goToAlbum }

// class _SongsListState extends State<SongsList> {

//   List<Song> _songs;
//   List<Song> duplicateSongs;
//   MusicFinder audioPlayer;

//   @override
//   void initState(){
//     super.initState();
//     // initSongs();
//   }

//   // Future<void> initSongs() async {
//   //   audioPlayer = new MusicFinder();
//   //   await MusicFinder.allSongs();
//   //   setState(() {
//   //    widget.songmodel.duplicateSongs = widget.songmodel.songs;
//   //   });
//   // }

//   // void filterSearchResults(String query) {
//   //   List<Song> dummySearchList = List<Song>();
//   //   dummySearchList = duplicateSongs;
//   //   if(query.isNotEmpty) {
//   //     List<Song> dummyListData = List<Song>();
//   //     for(int i=0;i<duplicateSongs.length;i++){
//   //       if(equalsIgnoreCase(query, dummySearchList[i].title)){
//   //         dummyListData.add(dummySearchList[i]);
//   //       }
//   //       setState(() {
//   //         _songs.clear();
//   //         _songs = dummyListData;
//   //       });
//   //     }
//   //   } else {
//   //     setState(() {
//   //       _songs.clear();
//   //       _songs.addAll(duplicateSongs);
//   //     });
//   //   }
//   // }

//   popUpMenuActions(MenuOptions result, int index){
//     switch(result){
//       case MenuOptions.addtoPlaylist:
//         widget.songmodel.playQueue.add(widget.songmodel.songs[index]);
//         break;
//       case MenuOptions.playNext:
//         widget.songmodel.currentSong = index;
//         break;
//       case MenuOptions.addToQueue:
//         widget.songmodel.playQueue.add(widget.songmodel.songs[index]);
//         break;
//       case MenuOptions.goToAlbum:
//         // TODO: Handle this case.
//         break;
//     }
//   }

//   _showPopupMenu(Offset offset) async {
//     double left = offset.dx;
//     double top = offset.dy;
//     await showMenu(
//     context: context,
//     position: RelativeRect.fromLTRB(left, top, 0, 0),
//     elevation: 8.0,
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: getSongs(),
//     );
//   }

//   getSongs(){
//     if (songs.length == null){
//       return Expanded(
//         child: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     } else {
//       return CustomScrollView(
//         slivers: <Widget>[
//           // SliverAppBar(
//           //   backgroundColor: Colors.transparent,
//           //   elevation: 0.0,
//           //   floating: true,
//           //   flexibleSpace: Column(
//           //     children: <Widget>[
//           //       Padding(
//           //         padding: const EdgeInsets.all(10.0),
//           //         child: Stack(
//           //           children: <Widget>[
//           //             Positioned(
//           //               left: 30.0, top:12.0,
//           //               child: IconButton(
//           //                 onPressed: () => Scaffold.of(context).openDrawer(),
//           //                 icon: Icon(Icons.drag_handle, color: Colors.black),
//           //               ),
//           //             ),
//           //             TextField(
//           //               style: TextStyle(
//           //                 fontSize: 20.0,
//           //               ),
//           //               textAlignVertical: TextAlignVertical.bottom,
//           //               textAlign: TextAlign.center,
//           //               decoration: InputDecoration(
//           //                 border: InputBorder.none,
//           //                 fillColor: Colors.grey[100],
//           //                 filled: true,
//           //                 hintText: 'Search',
//           //               ),
//           //             ),
//           //             Positioned(
//           //               right: 15.0, top: 12.0,
//           //               child: GestureDetector(
//           //                 onTapDown: (TapDownDetails details) {
//           //                   _showPopupMenu(details.globalPosition);
//           //                 },
//           //                 child: Icon(Icons.sort),
//           //               ),
//           //             ),
//           //           ]
//           //         ),
//           //       ),
//           //       Container(
//           //         width: 100,
//           //         height: 40,
//           //         decoration: BoxDecoration(
//           //           borderRadius: BorderRadius.circular(10.0),
//           //           color: Colors.grey[300],
//           //         ),
//           //         child: GestureDetector(
//           //           onTap: () {
//           //             widget.songmodel.shuffle = true;
//           //             widget.songmodel.getRandom();
//           //             Navigator.push(context, MaterialPageRoute(
//           //               builder: (context) => NowPlaying(
//           //                 songmodel: widget.songmodel,
//           //                 playSong: true),
//           //               )
//           //             );
//           //           },
//           //           child: Center(
//           //             child: Text(
//           //               'Shuffle All',
//           //               style: TextStyle(
//           //                 color: Colors.black
//           //                 ),
//           //               ),
//           //           ),
//           //           ),
//           //         )
//           //     ],
//           //   ),
//           //   expandedHeight: 110,
//           // ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 return ListTile(
//                   contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
//                   // leading: CircleAvatar(
//                   //   child: songs[index].albumArt != null ? 
//                   //           Image.file(File(songs[index].albumArt)): 
//                   //             Icon(Icons.music_note),
//                   // ),
//                   title: Text(songs[index].title.length >=20 ? 
//                           songs[index].title.substring(0,20) + '...' 
//                             : songs[index].title + '...'),
//                   subtitle: Text(songs[index].artist.length >=20 ? 
//                               songs[index].artist.substring(0,20) + '...' 
//                                 : songs[index].artist + '...',
//                         style: TextStyle(fontSize: 12.0),),
//                   onTap: () {
//                     widget.songmodel.currentSong = index;
//                     Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => NowPlaying(
//                       songmodel: widget.songmodel,
//                       playSong: true,
//                       ),
//                     )
//                   );
//                   },
//                   trailing: PopupMenuButton<MenuOptions>(
//                     onSelected: (MenuOptions result) { 
//                       setState(() { 
//                         popUpMenuActions(result, index); 
//                       }); 
//                     },
//                     itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOptions>>[
//                       const PopupMenuItem<MenuOptions>(
//                         value: MenuOptions.addtoPlaylist,
//                         child: Text('Add to Playlist'),
//                       ),
//                       const PopupMenuItem<MenuOptions>(
//                         value: MenuOptions.playNext,
//                         child: Text('Play Next'),
//                       ),
//                       const PopupMenuItem<MenuOptions>(
//                         value: MenuOptions.addToQueue,
//                         child: Text('Add to queue'),
//                       ),
//                       const PopupMenuItem<MenuOptions>(
//                         value: MenuOptions.goToAlbum,
//                         child: Text('Go to album'),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               childCount: songs.length,
//             ),
//           ),
//         ],
//       );
//     }
//   }

//   //       onChanged: (String value) {
//   //         filterSearchResults(value);
//   //       },
//   //       onTap: () {},
//   //       decoration: InputDecoration.collapsed(
//   //         hintText: "Search...",
//   //       ),
//   //       ),
//   //     );
//   // }
// }