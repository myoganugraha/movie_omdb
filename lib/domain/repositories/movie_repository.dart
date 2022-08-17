import 'package:movie_app/domain/entities/movie_details_entity.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> getMovieBySearch(String query);

  Future<MovieDetailsEntity> getMovieDetailsByImdbId(String imdbId);
}
