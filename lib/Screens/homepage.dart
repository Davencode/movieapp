import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Screens/movie_detail.dart';
import 'package:movieapp/Services/api_movie_db.dart';
import 'package:movieapp/bloc/movie_bloc/movie_bloc.dart';
import 'package:movieapp/bloc/movie_bloc/movie_event.dart';
import 'package:movieapp/bloc/movie_bloc/movie_state.dart';
import '../DataModel/movieModel.dart';

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
      body: Column(
        children: [
          Text(
            'MovieApp',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          TextButton(
            onPressed: () {
              context.read<MovieBloc>().add(MovieLoadedEvent());
            },
            child: const Text('Tap me to fetch movies'),
          ),
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieLoadedState) {
                  List<MovieModel> movies = state.movies;
                  return ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      var movie = movies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MovieDetail(movie: movie),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: movie.posterPath != null
                                      ? Image.network(
                                    'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                    width: 100,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                      : const Icon(Icons.movie, size: 100),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        style: Theme.of(context).textTheme.titleMedium,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Voto: ${movie.voteAverage.toStringAsFixed(1)}",
                                        style: Theme.of(context).textTheme.bodyMedium,
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
                  );
                } else if (state is MovieErrorState) {
                  return Center(
                    child: Text(
                      "Errore: ${state.message}",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
                return const SizedBox(); // Stato iniziale
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MovieAPIAuthentication().authenticate(context: context);
        },
        tooltip: 'Authenticate',
        child: const Icon(Icons.add),
      ),
    );
  }
}
