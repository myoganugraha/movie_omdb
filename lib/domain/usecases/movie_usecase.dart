import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';

class MovieUseCase {
  MovieUseCase({required this.movieRepository});

  final MovieRepository movieRepository;

  Future<List<MovieModel>> getMovieBySearch(String query) {
    return movieRepository.getMovieBySearch(query);
  }
}
