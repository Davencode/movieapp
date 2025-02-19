import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Screens/homepage.dart';
import 'package:movieapp/Screens/search_movie.dart';
import 'package:movieapp/Screens/settings.dart';
import 'package:movieapp/Screens/top_rated_movie.dart';
import 'package:movieapp/Services/movies.dart';

import 'Repositories/movie_repository.dart';
import 'bloc/movie_bloc/movie_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MovieBloc(MovieRepository(Movies()))),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Scaffold(
            body: Container(
              color: Colors.black,
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TabBarView(
                  children: [
                    HomePage(),
                    TopRatedMovie(),
                    SearchMovie(),
                    Settings(),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SizedBox(
              height: 80,
              child: Material(
                color: Colors.black,
                child: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.theaters)),
                    Tab(icon: Icon(Icons.star_rate)),
                    Tab(icon: Icon(Icons.search)),
                    Tab(icon: Icon(Icons.person_pin_circle_rounded)),
                  ],
                  labelColor: Color(0xFFE8E462),
                  unselectedLabelColor: Colors.blue,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.only(bottom: 30.0),
                  indicatorColor: Colors.red,
                  labelPadding: EdgeInsets.only(bottom: 20),
                  isScrollable: false,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
