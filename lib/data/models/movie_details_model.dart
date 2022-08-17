import 'package:movie_app/data/models/rating_model.dart';
import 'package:movie_app/domain/entities/movie_details_entity.dart';

class MovieDetailsModel extends MovieDetailsEntity {
  MovieDetailsModel({
    required super.title,
    required super.year,
    required super.rated,
    required super.released,
    required super.runtime,
    required super.genre,
    required super.director,
    required super.writer,
    required super.actors,
    required super.plot,
    required super.language,
    required super.country,
    required super.awards,
    required super.poster,
    required super.ratings,
    required super.metascore,
    required super.imdbRating,
    required super.imdbVotes,
    required super.imdbID,
    required super.type,
    required super.dvd,
    required super.boxOffice,
    required super.production,
    required super.website,
    required super.response,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      title: json['Title'] as String,
      year: json['Year'] as String,
      rated: json['Rated'] as String,
      released: json['Released'] as String,
      runtime: json['Runtime'] as String,
      genre: json['Genre'] as String,
      director: json['Director'] as String,
      writer: json['Writer'] as String,
      actors: json['Actors'] as String,
      plot: json['Plot'] as String,
      language: json['Language'] as String,
      country: json['Country'] as String,
      awards: json['Awards'] as String,
      poster: json['Poster'] as String,
      metascore: json['Metascore'] as String,
      imdbRating: json['imdbRating'] as String,
      imdbVotes: json['imdbVotes'] as String,
      imdbID: json['imdbID'] as String,
      type: json['Type'] as String,
      dvd: json['DVD'] as String,
      boxOffice: json['BoxOffice'] as String,
      production: json['Production'] as String,
      website: json['Website'] as String,
      response: json['Response'] as String,
      ratings: (json['Ratings'] as List<dynamic>)
          .map((data) => RatingModel.fromJson(data as Map<String, dynamic>))
          .toList(),
    );
  }
}
