import 'package:flutter/material.dart';
import 'package:quickbuy/views/favorite_view/favoriteproductspage.dart';
import 'package:quickbuy/views/profileview/ProfileView.dart';
import '../views/categoryview/categoryview.dart';
import '../views/home_view.dart';
import 'colors.dart';

class CustomNavigation extends StatefulWidget {
  const CustomNavigation({super.key});

  @override
  State<CustomNavigation> createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeView(),          // Home screen
    Categoryview(),      // Category screen
    FavoriteProductsPage(),
    ProfileView(), // Card screen (replace with your actual screen)
    // Setting screen (replace with your actual screen)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],  // Update this line to show the correct page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        selectedItemColor: CustomColors.primarycolor,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}