// ignore_for_file: one_member_abstracts

import 'package:movie_app/data/models/movie_model.dart';

abstract class MovieRepository {
  Future<List<MovieModel>> getMovieBySearch(String query);
}
