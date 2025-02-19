import 'package:flutter/material.dart';

class TopRatedMovie extends StatefulWidget {
  const TopRatedMovie({super.key});

  @override
  State<TopRatedMovie> createState() => _TopRatedMovieState();
}

class _TopRatedMovieState extends State<TopRatedMovie> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Text('This is top rated area'),
    );
  }
}
