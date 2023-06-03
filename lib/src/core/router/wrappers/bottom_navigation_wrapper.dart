import 'package:flutter/material.dart';
import 'package:news_universe/src/features/favorites/favorites_screen.dart';
import 'package:news_universe/src/features/home/home.screen.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_universe/src/features/settings/setting_screen.dart';
import 'package:news_universe/src/shared/utils/common.dart';

class BottomNavigationWrapper extends StatelessWidget {
  BottomNavigationWrapper({super.key});

  final List<Widget> screens = [
    const HomeScreen(),
    const FavoritesScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return HookBuilder(builder: (context) {
      final currentIndex = useState(0);

      return Scaffold(
        body: screens[currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex.value,
          onTap: (index) => currentIndex.value = index,
          items: bottomNavigationBarItem(context),
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      );
    });
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
