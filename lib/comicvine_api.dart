import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/comic.dart'; // Assurez-vous que le chemin est correct

class ComicVineApi {
  final String apiKey = '997591ee88b39fa5e37f02acae7bb85f663a27bf';
  final String baseUrl = 'https://comicvine.gamespot.com/api/issues/';
  
  Future<List<Comic>> fetchComics() async {
    var url = Uri.parse('${baseUrl}?api_key=${apiKey}&format=json&limit=20');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Comic> comics = (data['results'] as List)
          .map((comicJson) => Comic.fromJson(comicJson))
          .toList();
      return comics;
    } else {
      throw Exception('Failed to load comics. Status code: ${response.statusCode}');
    }
  }
}

