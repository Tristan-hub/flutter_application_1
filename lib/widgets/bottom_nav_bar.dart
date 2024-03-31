import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BottomNavigationBar(
        backgroundColor: const Color(0xFF0F1E2B),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'lib/assets/svg/navbar_home.svg',
              color: selectedIndex == 0 ? const Color(0xFF3284e7) : const Color(0xFF778BA8),
            ),
            activeIcon: SvgPicture.asset(
              'lib/assets/svg/navbar_home.svg',
              color: const Color(0xFF3284e7),
            ),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'lib/assets/svg/navbar_comics.svg',
              color: selectedIndex == 1 ? const Color(0xFF3284e7) : const Color(0xFF778BA8),
            ),
            activeIcon: SvgPicture.asset(
              'lib/assets/svg/navbar_comics.svg',
              color: const Color(0xFF3284e7),
            ),
            label: 'Comics',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'lib/assets/svg/navbar_series.svg',
              color: selectedIndex == 2 ? const Color(0xFF3284e7) : const Color(0xFF778BA8),
            ),
            activeIcon: SvgPicture.asset(
              'lib/assets/svg/navbar_series.svg',
              color: const Color(0xFF3284e7),
            ),
            label: 'Séries',
          ),
          
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'lib/assets/svg/navbar_movies.svg',
              color: selectedIndex == 3 ? const Color(0xFF3284e7) : const Color(0xFF778BA8),
            ),
            activeIcon: SvgPicture.asset(
              'lib/assets/svg/navbar_movies.svg',
              color: const Color(0xFF3284e7),
            ),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'lib/assets/svg/navbar_search.svg',
              color: selectedIndex == 4 ? const Color(0xFF3284e7) : const Color(0xFF778BA8),
            ),
            activeIcon: SvgPicture.asset(
              'lib/assets/svg/navbar_search.svg',
              color: const Color(0xFF3284e7),
            ),
            label: 'Recherche',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xFF3284e7),
        unselectedItemColor: const Color(0xFF778BA8),
        onTap: onItemSelected,
      ),
    );
  }
}
