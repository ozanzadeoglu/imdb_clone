import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationBar extends StatelessWidget {
  final String currentRoute;

  const CustomNavigationBar({super.key, required this.currentRoute});
  final String homeLabel = "home";
  final String searchLabel = "search";
  final String bookmarkLabel = "bookmark";

  int _getCurrentIndex() {
    if (currentRoute == "/") {
      return 0;
    } else if (currentRoute.startsWith("/search")) {
      return 1;
    } else if (currentRoute.startsWith("/bookmark")) {
      return 2;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 32,
      currentIndex: _getCurrentIndex(),
      onTap: (index) {
        if (index == 0) {
          context.goNamed('home');
        } else if (index == 1) {
          context.goNamed('search');
        } else if (index == 2) {
          context.goNamed('bookmark');
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.home_outlined,
          ),
          activeIcon: const Icon(Icons.home, color: Colors.white),
          label: homeLabel,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.search_outlined),
          activeIcon: const Icon(Icons.search, color: Colors.white, fill: 1),
          label: searchLabel,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.bookmark_border_sharp),
          activeIcon: const Icon(Icons.bookmark),
          label: bookmarkLabel,
        ),
      ],
    );
  }
}
