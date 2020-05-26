import 'dart:convert';

class Song {
  String title;
  String albumID;
  String artistID;
  String album;
  String artist;
  String composer;
  String year;
  String fileSize;
  String filePath;
  String track;
  String duration;
  String bookmark;
  String albumArtwork;

  Song(
      {this.title,
      this.album,
      this.albumArtwork,
      this.albumID,
      this.artist,
      this.artistID,
      this.duration,
      this.bookmark,
      this.composer,
      this.filePath,
      this.fileSize,
      this.track,
      this.year});

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
        title: json['title'],
        album: json['album'],
        albumArtwork: json['albumArtwork'],
        albumID: json['albumID'],
        artist: json['artist'],
        artistID: json['artistID'],
        duration: json['duration'],
        bookmark: json['bookmark'],
        composer: json['composer'],
        track: json['track'],
        year: json['year'],
        filePath: json['filePath'],
        fileSize: json['size']); 
        //* 0.00000095367432);
  }

  static Map<String, dynamic> toMap(Song song) => {
        'title': song.title,
        'album': song.album,
        'albumArtwork': song.albumArtwork,
        'albumID': song.albumID,
        'artist': song.artist,
        'artistID': song.artistID,
        'duration': song.duration,
        'bookmark': song.bookmark,
        'composer': song.composer,
        'track': song.track,
        'year': song.year,
        'filePath': song.filePath,
        'fileSize': song.fileSize
      };

  static String encodeSong(List<Song> song) => json.encode(
        song.map<Map<String, dynamic>>((song) => Song.toMap(song)).toList(),
      );

  static List<Song> decodeSong(String song) =>
      (json.decode(song) as List<dynamic>)
          .map<Song>((item) => Song.fromJson(item))
          .toList();
}
