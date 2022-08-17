// ignore_for_file: one_member_abstracts
import 'package:movie_app/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> getMovieBySearch(String query);
}
