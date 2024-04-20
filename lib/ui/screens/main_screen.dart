import 'package:flutter/material.dart';
import 'package:pokemon_music_player/services/song_handler.dart';
import 'package:pokemon_music_player/ui/components/bottom_navigation_bar.dart';
import 'package:pokemon_music_player/ui/screens/home_screen.dart';
import 'package:pokemon_music_player/ui/screens/search_screen.dart';
import 'package:pokemon_music_player/ui/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  final SongHandler songHandler;

  const MainScreen({super.key, required this.songHandler});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.detached) {
      widget.songHandler.stop();
      widget.songHandler.dispose();
    }
  }

  void onTabTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              HomeScreen(songHandler: widget.songHandler),
              SearchScreen(songHandler: widget.songHandler,),
              const SettingsPage(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        onTabTapped: onTabTapped,
        currentIndex: _currentIndex,),
    );
  }
}
