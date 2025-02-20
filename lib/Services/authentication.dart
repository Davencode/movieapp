import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movieapp/Utilities/strings.dart';

class MovieAPIAuthentication {

  final String baseUrl = '${MovieAPI().domain}${MovieAPI().endpointAuth}';

  Future<void> authenticate({required BuildContext context}) async {

    print('BASE URL E ${baseUrl}');

    try {
      var url = Uri.parse(baseUrl);
      Map<String, String> headers = {
        'Authorization': 'Bearer ${MovieAPI().bearerToken}',
        'Content-Type': 'application/json'
      };

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login riuscito! Benvenuto, ${userData['username'] ?? 'utente'}'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore: ${response.reasonPhrase}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Dati non validi, riprovare. Errore: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
