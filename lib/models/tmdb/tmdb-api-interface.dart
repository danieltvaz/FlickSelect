import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class TmdbApiInterface {
  final baseUrl = 'https://api.themoviedb.org/3';
  final apiKey = dotenv.get('TMDB_API_KEY');

  Future<Map<String, dynamic>> getMoviesList(
      {int? page = 1, int? genre}) async {
    var request = await http.get(
        Uri.parse(
            '$baseUrl/discover/movie?include_adult=false&include_video=false&language=pt-BR&page=$page&with_genres=$genre&sort_by=popularity.desc'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $apiKey'});

    var movies = jsonDecode(request.body) as Map<String, dynamic>;
    return movies;
  }

  Future<List<dynamic>> getMoviesGenres() async {
    var request = await http.get(
        Uri.parse('$baseUrl/genre/movie/list?language=pt-BR'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $apiKey'});

    var genres = jsonDecode(request.body)['genres'];
    return genres;
  }

  Future<List<dynamic>> getMovieProviders(int movieId) async {
    try {
      var request = await http.get(
          Uri.parse('$baseUrl/movie/$movieId/watch/providers'),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $apiKey'});

      var providers = jsonDecode(request.body)['results']['BR']['flatrate'];
      return providers;
    } catch (error) {
      return [];
    }
  }
}
