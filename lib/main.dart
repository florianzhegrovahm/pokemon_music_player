import 'package:audio_service/audio_service.dart';
import 'package:pokemon_music_player/notifiers/songs_provider.dart';
import 'package:pokemon_music_player/services/song_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_music_player/notifiers/theme_provider.dart';
import 'package:pokemon_music_player/ui/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

// Create a singleton instance of SongHandler
SongHandler _songHandler = SongHandler();

// Entry point of the application
Future<void> main() async {
  // Ensure that the Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AudioService with the custom SongHandler
  _songHandler = await AudioService.init(
    builder: () => SongHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.pokemon_music_player.app',
      androidNotificationChannelName: 'pokemon_music_player Player',
      androidNotificationOngoing: true,
      androidShowNotificationBadge: true,
    ),
  );

  // Run the application
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        // Provide the SongsProvider with the loaded songs and SongHandler
        ChangeNotifierProvider(create: (context) => SongsProvider()..loadSongs(_songHandler),
        ),
      ],
      // Use the MainApp widget as the root of the application
      child: const MainApp(),
    ),
  );

  // Set preferred orientations for the app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

// Root application widget
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Build the app using DynamicColorBuilder
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      // Set HomeScreen as the initial screen with the provided SongHandler
      home: MainScreen(songHandler: _songHandler),
    );
  }
}
