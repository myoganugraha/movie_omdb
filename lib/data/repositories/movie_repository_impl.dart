import 'package:movie_app/data/datasources/remote/movie_remote_datasource.dart';
import 'package:movie_app/data/models/movie_details_model.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl({required this.movieRemoteDatasource});

  final MovieRemoteDatasource movieRemoteDatasource;

  @override
  Future<List<MovieModel>> getMovieBySearch(String query) {
    return movieRemoteDatasource.getMovieBySearch(query);
  }

  @override
  Future<MovieDetailsModel> getMovieDetailsByImdbId(String imdbId) {
    return movieRemoteDatasource.getMovieDetailsByImdbId(imdbId);
  }
}
