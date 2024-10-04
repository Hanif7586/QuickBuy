import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/carouselslider.dart';
import '../widgets/colors.dart';
import '../widgets/custom_bar.dart';
import '../widgets/futurebuilder.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<String> imageList = [
    'assets/one.png',
    'assets/three.png',
    'assets/two.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: CustomColors.primarycolor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomBar(),
              Carouselslider(),
              Futurebuilder()
            ],
          ),
        ),
      ),
    );
  }
}
