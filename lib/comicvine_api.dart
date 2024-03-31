import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/comics.dart'; 
import 'models/series.dart'; 
import 'models/movies.dart';

class ComicVineApi {
  final String apiKey = '997591ee88b39fa5e37f02acae7bb85f663a27bf';
  final String baseUrl = 'https: comicvine.gamespot.com/api';

  Future<List<Comics>> fetchComics() async {
    var url = Uri.parse('$baseUrl/issues/?api_key=$apiKey&format=json&limit=50');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Comics> comics = (data['results'] as List)
          .map((comicJson) => Comics.fromJson(comicJson))
          .toList();
      return comics;
    } else {
      throw Exception('Failed to load comics. Status code: ${response.statusCode}');
    }
  }

  Future<List<Series>> fetchSeries() async {
    var url = Uri.parse('$baseUrl/series_list/?api_key=$apiKey&format=json&limit=50');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Series> series = (data['results'] as List)
          .map((seriesJson) => Series.fromJson(seriesJson))
          .toList();
      return series;
    } else {
      throw Exception('Failed to load series. Status code: ${response.statusCode}');
    }
  }

  Future<List<Movies>> fetchMovies() async {
    var url = Uri.parse('$baseUrl/movies/?api_key=$apiKey&format=json&limit=50');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Movies> movies = (data['results'] as List)
          .map((movieJson) => Movies.fromJson(movieJson))
          .toList();
      return movies;
    } else {
      throw Exception('Failed to load movies. Status code: ${response.statusCode}');
    }
  }
}
