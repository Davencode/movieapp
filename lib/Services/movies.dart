import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../DataModel/movie_model.dart';
import '../Utilities/strings.dart';

class Movies {

  final String baseUrl = '${MovieAPI().domain}${MovieAPI().endPointDiscoverMovie}';

  Future<List<MovieModel>> fetchMovies() async {
    try {
      var url = Uri.parse(baseUrl);
      Map<String, String> headers = {
        'Authorization': 'Bearer ${MovieAPI().bearerToken}',
        'Content-Type': 'application/json',
      };

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        List<MovieModel> movies = (data['results'] as List)
            .map((movieJson) => MovieModel.fromJson(movieJson))
            .toList();

        return movies;
      } else {
        print("Nulla da fetchare, errore");
        return [];
      }
    } catch (e) {
      print('Errore ${e}');
      return [];
    }
  }
}
