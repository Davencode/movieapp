import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movieapp/DataModel/movie_model.dart';

class MovieDetail extends StatelessWidget {
  final MovieModel movie;

  const MovieDetail({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(movie.title, style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black.withOpacity(0.5),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: movie.posterPath != null
                ? Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              fit: BoxFit.cover,
            )
                : Container(color: Colors.black)
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: movie.posterPath != null
                      ? Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    height: 350,
                    fit: BoxFit.cover,
                  )
                      : const Icon(Icons.movie, size: 100, color: Colors.white),
                ),
                const SizedBox(height: 20),
                Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 28),
                    const SizedBox(width: 6),
                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Text(
                    movie.overview.isNotEmpty ? movie.overview : "Nessuna descrizione disponibile.",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
