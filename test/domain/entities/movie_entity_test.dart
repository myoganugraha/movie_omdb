import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/domain/entities/__mocks__/movie_entity_mock.dart';

void main() {
  group('Movie entity', () {
    test('should init movie entity correctly', () {
      // Given
      const movieTitle = 'title';
      const movieYear = '2022';
      const movieImdbID = 'tt0372784';
      const movieType = 'movie';
      const moviePoster = 'www.google.com';

      // When
      final movieEntity = mockMovieEntity;

      // Then
      expect(movieEntity.title, movieTitle);
      expect(movieEntity.year, movieYear);
      expect(movieEntity.imdbID, movieImdbID);
      expect(movieEntity.type, movieType);
      expect(movieEntity.poster, moviePoster);
    });
  });
}
