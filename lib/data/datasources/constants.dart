import 'package:flutter_dotenv/flutter_dotenv.dart';

class DatasourcesConstants {
  static String apikey = dotenv.env['omdb_apikey']!;
  static String baseURL = 'https://www.omdbapi.com/?apikey=$apikey&type=movie';
  static String searchMovieEndpoint = '$baseURL&s=';
  static String movieDetailsEndpoint = '$baseURL&plot=short&i=';
}
