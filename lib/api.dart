import 'dart:convert';
import 'package:http/http.dart' as http;

//class TmdbApi dingunakan untuk merequest/mengambil data dari api
class TmdbApi {
  static const String apiKey = '2c19b72b3ad10852f55b6d5e37566e7e';
  // pada static Future ini akan merequest data dari api
  static Future<List<dynamic>> getPopularMovies() async {
    final response = await http.get(Uri.https(
      'api.themoviedb.org',
      '/3/movie/popular',
      {'api_key': apiKey},
    ));

    //pada seleksi if akan memvalidasi apakah respon berhasil atau tidak
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      //mengembalikan data yang di dapat dari internet
      return body['results'];
    } else {
      throw Exception('Failed to load popular movies');
    }
  }
}