// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// class TMDBApiHelper {
//   static String apiKey = dotenv.env['TMDB_API_KEY'] ?? '';
//   static const String baseUrl = 'https://api.themoviedb.org/3';
//   static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

//   static Future<List<Map<String, dynamic>>> fetchMovies(int page) async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&page=$page'),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return List<Map<String, dynamic>>.from(data['results']);
//     } else {
//       throw Exception('Whoops, failed to load movies!');
//     }
//   }
// }
