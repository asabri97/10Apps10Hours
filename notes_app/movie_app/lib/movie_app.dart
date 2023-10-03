import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'movie.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies App'),
      ),
      body: FutureBuilder<Movies>(
        future: fetchMovies(),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            final movies = snapshot.data!.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var movie in movies)
                    Container(
                      margin: const EdgeInsets.all(18),
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  '${movie.name} (${movie.releaseDate.year})',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text('Rating: ${movie.rate}/10'),
                          const SizedBox(height: 10),
                          Text(movie.overwatch),
                        ],
                      ),
                    ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Error loading data'),
            );
          }
        },
      ),
    );
  }
}

Future<Movies> fetchMovies() async {
  final response =
      await http.get(Uri.parse('https://www.fluttermovie.top/api/Movies/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Movies.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
