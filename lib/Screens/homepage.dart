import 'package:flutter/material.dart';
import 'package:movieapp/Services/api_movie_db.dart';
import 'package:movieapp/Services/movies.dart';
import '../Model/movieModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MovieModel> movies = [];
  bool isLoading = false;

  void fetchMovies() async {
    setState(() {
      isLoading = true;
    });

    List<MovieModel> fetchedMovies = await Movies().fetchMovies(context: context);

    setState(() {
      movies = fetchedMovies;
      isLoading = false;
    });
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
            onPressed: fetchMovies,
            child: const Text('Tap me to fetch movies'),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                var movie = movies[index];
                return Card(
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
                );
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
