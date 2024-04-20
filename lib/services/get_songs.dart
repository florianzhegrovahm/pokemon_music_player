import 'package:audio_service/audio_service.dart';
import 'package:pokemon_music_player/services/request_song_permission.dart';
import 'package:pokemon_music_player/services/song_to_media_item.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

// Asynchronous function to get a list of MediaItems representing songs
Future<List<MediaItem>> getSongs() async {
  try {
    // Ensure that the necessary permissions are granted
    await requestSongPermission();

    // List to store the MediaItems representing songs
    final List<MediaItem> songs = [];

    // Create an instance of OnAudioQuery for querying songs
    final OnAudioQuery onAudioQuery = OnAudioQuery();

    // Query the device for song information using OnAudioQuery
    final List<SongModel> songModels = await onAudioQuery.querySongs();

    const desiredPath = '/storage/emulated/0/PokéRadio/';
    const filterSongLength = true;
    const desiredSongLength = 30000;

    // Convert each SongModel to a MediaItem and add it to the list of songs
    songModels.where((songModel) => songModel.data
      .startsWith(desiredPath))
        .where((songModel) {
          if (filterSongLength) {
            return songModel.duration != null ? songModel.duration! >= desiredSongLength : true;
          } else {
            return true;
          }
      })
      .forEach((songModel) async {
        final MediaItem song = await songToMediaItem(songModel);
        songs.add(song);
    });

    // Return the list of songs
    return songs;
  } catch (e) {
    // Handle any errors that occur during the process
    debugPrint('Error fetching songs: $e');
    return []; // Return an empty list in case of error
  }
}
