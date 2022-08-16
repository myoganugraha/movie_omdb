// ignore_for_file: avoid_dynamic_calls

import 'package:movie_app/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required super.title,
    required super.year,
    required super.imdbID,
    required super.type,
    required super.poster,
  });

  factory MovieModel.fromJson(dynamic json) => MovieModel(
        title: json['Title'] as String,
        year: json['Year'] as String,
        imdbID: json['imdbID'] as String,
        type: json['Type'] as String,
        poster: json['Poster'] as String,
      );
}
