// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_app/data/datasources/constants.dart';
import 'package:movie_app/data/models/movie_details_model.dart';
import 'package:movie_app/data/models/movie_model.dart';

class MovieRemoteDatasource {
  MovieRemoteDatasource(this._httpClient);

  final Client _httpClient;

  Future<List<MovieModel>> getMovieBySearch(String query) async {
    try {
      final result = await _httpClient.get(
        Uri.parse(DatasourcesConstants.searchMovieEndpoint + query),
      );
      return MovieModel.fromJsonList(
        jsonDecode(result.body) as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<MovieDetailsModel> getMovieDetailsByImdbId(String imdbId) async {
    try {
      final result = await _httpClient.get(
        Uri.parse(DatasourcesConstants.searchMovieEndpoint),
      );
      return MovieDetailsModel.fromJson(
        jsonDecode(result.body) as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
