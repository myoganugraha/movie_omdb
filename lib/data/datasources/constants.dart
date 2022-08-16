import 'package:flutter_dotenv/flutter_dotenv.dart';

class DatasourcesConstants {
  static String token = dotenv.env['omdb_dev_apikey']!;
  static String baseURL = 'https://www.omdbapi.com/?apikey=$token}';
  static String searchMovieEndpoint = '$baseURL&s=';
}
