import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carouselslider extends StatelessWidget {
   Carouselslider({super.key});

  final List<String> imageList = [
    'assets/one.png',
    'assets/three.png',
    'assets/two.png',
  ];

  @override
  Widget build(BuildContext context) {
    return  CarouselSlider(
      options: CarouselOptions(
        height: 200,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: imageList.map((item) => Container(
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0), // Set the radius here
            child: Image.asset(item, fit: BoxFit.cover, width: 1000),
          ),
        ),
      )).toList(),
    );
  }
}
