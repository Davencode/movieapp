import 'package:movieapp/DataModel/movieModel.dart';
import 'package:movieapp/Services/movies.dart';
import 'package:movieapp/Utilities/strings.dart';
import 'package:flutter/material.dart';

class MovieRepository {
  final Movies apiService;

  MovieRepository(this.apiService);

  Future<List<MovieModel>> getMovies() async {
    return await apiService.fetchMovies();
  }
}
