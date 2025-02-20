import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Screens/movie_detail.dart';
import 'package:movieapp/Services/authentication.dart';
import 'package:movieapp/bloc/movie_bloc/movie_bloc.dart';
import 'package:movieapp/bloc/movie_bloc/movie_event.dart';
import 'package:movieapp/bloc/movie_bloc/movie_state.dart';
import '../DataModel/movie_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(MovieLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060D59),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('images/LogoAPP.png', scale: 6.0),
                ],
              ),
              BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MovieLoadedState) {
                    List<MovieModel> movies = state.movies;
                    if (movies.isEmpty) {
                      return const Center(child: Text("Nessun film disponibile"));
                    }
                    var firstMovie = movies.first;
                    var remainingMovies = movies.sublist(1);
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MovieDetail(movie: firstMovie),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Image.network(
                                    'https://image.tmdb.org/t/p/w500${firstMovie.backdropPath}',
                                    width: double.infinity,
                                    height: 350,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 350,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.2),
                                          const Color(0xFF060D59).withOpacity(1.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 20,
                                child: ClipRRect(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 3),
                                    ),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w200${firstMovie.posterPath}',
                                      width: 200,
                                      height: 300,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 40,
                                child: Card(
                                  color: Colors.black.withOpacity(0.3),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.star, color: Colors.yellow, size: 24),
                                        const SizedBox(width: 5),
                                        Text(
                                          firstMovie.voteAverage.toStringAsFixed(1),
                                          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true, // Necessario per ListView all'interno di SingleChildScrollView
                          physics: const NeverScrollableScrollPhysics(), // Evita conflitti di scroll
                          itemCount: remainingMovies.length,
                          itemBuilder: (context, index) {
                            var movie = remainingMovies[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetail(movie: movie),
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.white.withOpacity(0.3),
                                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: movie.posterPath != null
                                            ? Image.network(
                                          'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                          width: 90,
                                          height: 130,
                                          fit: BoxFit.contain,
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Icon(Icons.broken_image, size: 90, color: Colors.white70);
                                          },
                                        )
                                            : const Icon(Icons.movie, size: 90, color: Colors.white70),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              movie.title,
                                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                const Icon(Icons.star, color: Colors.yellow, size: 18),
                                                const SizedBox(width: 4),
                                                Text(
                                                  movie.voteAverage.toStringAsFixed(1),
                                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Container(
                                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: movie.releaseDate != null &&
                                                    DateTime.tryParse(movie.releaseDate)?.isAfter(DateTime.now()) == true
                                                    ? Colors.orange.withOpacity(0.8)
                                                    : Colors.green.withOpacity(0.8),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                DateTime.tryParse(movie.releaseDate)?.isAfter(DateTime.now()) == true
                                                    ? 'Non ancora al cinema'
                                                    : 'Al cinema!',
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else if (state is MovieErrorState) {
                    return Center(
                      child: Text(
                        "Errore: ${state.message}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
