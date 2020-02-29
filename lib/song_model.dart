import 'dart:math';
import 'package:flute_music_player/flute_music_player.dart';

class SongModel {
  int currentSong = 0;
  var songs = <Song>[];
  var duplicateSongs = <Song>[];
  var playQueue = <Song>[];
  MusicFinder audioPlayer;
  bool isPlaying = true;
  bool shuffle = true;
  String repeatMode = 'ALL';

  Duration duration = new Duration();
  Duration position = new Duration();

  SongModel(){
    fetchSongs();
  }

  fetchSongs() async {
    songs = await MusicFinder.allSongs();
    // songs.forEach((element) {
    //   duplicateSongs.add(element);
    // });
  }

  playLocal(String uri) async {
    final result = await audioPlayer.play(uri, isLocal: true);
  }

  pause() async {
    final result = await audioPlayer.pause();
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