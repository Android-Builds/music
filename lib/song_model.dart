import 'package:flute_music_player/flute_music_player.dart';

class songModel {
  int currentSong = 0;
  var songs = <Song>[];
  var duplicateSongs = <Song>[];
  MusicFinder audioPlayer;

  Duration duration = new Duration();
  Duration position = new Duration();

  songModel(){
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

  repeat() {
    audioPlayer.play(songs[currentSong].uri, isLocal: true);
  }

  void seekToSecond(double second){
    audioPlayer.seek(second);
  }

  void getNext(){
    if(currentSong == songs.length-1) {
      currentSong = 0;
    } else {
      ++currentSong;
    }
  }

  void getPrev(){
    if(currentSong == 0) {
      currentSong = 0;
    } else {
      --currentSong;
    }
  }
}

songModel songmodel;