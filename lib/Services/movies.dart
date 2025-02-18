import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Model/movieModel.dart';
import '../Utilities/strings.dart';

class Movies {
  final String baseUrl =
      '${MovieAPI().domain}${MovieAPI().endPointDiscoverMovie}';

  Future<List<MovieModel>> fetchMovies({required BuildContext context}) async {
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore: ${response.reasonPhrase}'),
            backgroundColor: Colors.red,
          ),
        );
        return [];
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Dati non validi, riprovare. Errore: $e'),
          backgroundColor: Colors.red,
        ),
      );
      return [];
    }
  }
}
