import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickbuy/widgets/custom_navigation.dart';
import 'package:quickbuy/widgets/favoritesprovider.dart'; // Import your FavoritesProvider

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()..loadFavorites()), // Add FavoritesProvider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CustomNavigation(),
      ),
    );
  }
}
