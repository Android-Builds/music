import 'dart:math';
import 'package:flute_music_player/flute_music_player.dart';

class SongModel {
  int currentSong = 0;
  var songs = <Song>[];
  var duplicateSongs = <Song>[];
  var playQueue = <Song>[];
  var albums;
  MusicFinder audioPlayer;
  bool isPlaying = false;
  bool shuffle = true;
  String repeatMode = 'ALL';

  Duration duration = new Duration();
  Duration position = new Duration();

  SongModel(){
    fetchSongs();
    // fetchAlbums();
  }

  Map<T, List<S>> groupBy<S, T>(Iterable<S> values, T key(S element)) {
    var map = <T, List<S>>{};
    for (var element in values) {
      var list = map.putIfAbsent(key(element), () => []);
      list.add(element);
    }
    return map;
  }

  // fetchAlbums() {
  //   albums = Map.fromIterable(songs, key: (e) => e.album, value: (element) => element);
  // }

  fetchSongs() async {
    try {
      songs = await MusicFinder.allSongs();
    } catch (e) {
      print("Failed to get songs: '${e.message}'.");
    }
  }

  playLocal(String uri) async {
    await audioPlayer.play(uri, isLocal: true);
  }

  pause() async {
    await audioPlayer.pause();
  }

  setRepeatMode(){
    if(repeatMode == 'ALL') {
      repeatMode = 'ONE';
    } else if(repeatMode == 'ONE') {
      repeatMode = 'OFF';
    } else {
      repeatMode = 'ALL';
    }
  }

  setShuffleMode(){
    if(shuffle){
      shuffle = false;
    } else {
      shuffle = true;
    }
  }

  repeatSongs() {
    audioPlayer.play(songs[currentSong].uri, isLocal: true);
  }

  void seekToSecond(double second){
    audioPlayer.seek(second);
  }

  void getNextSong(){
    if(currentSong == songs.length-1) {
      currentSong = 0;
    } else {
      ++currentSong;
    }
  }

  void getNext(){
    if(repeatMode == 'ALL'){
      if(shuffle == true){
        getRandom();
      } else{
        getNextSong();
      }
    } else if (repeatMode == 'OFF'){
      if (currentSong == songs.length-1){
        currentSong = currentSong;
      } else {
        if (shuffle == true) {
          getRandom();
        } else {
          getNextSong();
        }  
      }
    } else {
      currentSong = currentSong;
    }
  }

  void getRandom(){
    Random random = new Random();
    currentSong = random.nextInt(songs.length); 
  }

  void getPrev(){
    if(currentSong == 0) {
      currentSong = 0;
    } else {
      --currentSong;
    }
  }
}