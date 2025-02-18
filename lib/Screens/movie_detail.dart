import 'package:flutter/material.dart';
import 'package:movieapp/DataModel/movieModel.dart';

class MovieDetail extends StatelessWidget {
  final MovieModel movie;

  const MovieDetail({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: movie.posterPath != null
                    ? Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  height: 300,
                  fit: BoxFit.cover,
                )
                    : const Icon(Icons.movie, size: 100),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              movie.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              "Voto: ${movie.voteAverage.toStringAsFixed(1)}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            Text(
              movie.overview.isNotEmpty ? movie.overview : "Nessuna descrizione disponibile.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
