import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:movieapp/Utilities/strings.dart';
import '../DataModel/movie_model.dart';
import 'movie_detail.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({super.key});

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  TextEditingController _controller = TextEditingController();
  String query = '';
  List<dynamic> _movies = [];
  bool _isLoading = false;

  Future<void> _searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        _movies = [];
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?query=$query&include_adult=false&language=en-US&page=1');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${MovieAPI().bearerToken}',
          'accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['results'] is List) {
          setState(() {
            _movies = (data['results'] as List)
                .map((movie) => MovieModel.fromJson(movie))
                .toList();
            _isLoading = false;
          });
        } else {
          setState(() {
            _movies = [];
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        throw Exception('Errore nella richiesta: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Errore durante il caricamento dei film: $e');
    }
  }

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return 'No release date';
    try {
      DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
        title: const Text('Search Movie'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  query = value;
                });
                _searchMovies(value);
              },
              decoration: InputDecoration(
                labelText: 'Search movies...',
                hintText: 'Enter movie name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                height: MediaQuery.of(context).size.height * 0.75, // Altezza adattiva
                child: ListView.builder(
                  itemCount: _movies.length,
                  itemBuilder: (context, index) {
                    final MovieModel movie = _movies[index];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MovieDetail(movie: movie),
                          ),
                        );
                      },
                      leading: movie.posterPath != null
                          ? Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}')
                          : null,
                      title: Text(movie.title, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          formatDate(movie.releaseDate) ?? 'No release date'
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
