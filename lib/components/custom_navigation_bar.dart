import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationBar extends StatelessWidget {
  final String currentRoute;

  const CustomNavigationBar({super.key, required this.currentRoute});
  final String homeLabel = "home";
  final String searchLabel = "search";


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(   
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 32,
      currentIndex: currentRoute.startsWith("/search") ? 1 : 0,
      onTap: (index) {
        if (index == 0) {
          context.goNamed('home');
        } else if (index == 1) {
          context.goNamed('search');
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined,),
          activeIcon: const Icon(Icons.home, color: Colors.white,),
          label: homeLabel,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.search_outlined),
          activeIcon: const Icon(Icons.search, color: Colors.white, fill: 1),
          label: searchLabel,
        ),
      ],
    );
  }
} 

