import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/data/models/__mocks__/movie_model_mock.dart';
import 'package:movie_app/data/models/movie_model.dart';

void main() {
  group('Movie model', () {
    test(
        'should set the data '
        'from valid json', () {
      // Given
      final mockData = mockMovieModelJson;

      // When
      final movieModel = MovieModel.fromJson(mockData);

      // Then
      expect(movieModel.title, mockData['Title']);
      expect(movieModel.year, mockData['Year']);
      expect(movieModel.imdbID, mockData['imdbID']);
      expect(movieModel.type, mockData['Type']);
      expect(movieModel.poster, mockData['Poster']);
    });

    test(
        'should return list '
        'from valid json structure', () {
      // Given
      final mockData = mockMovieListModelJson;

      // When
      final movieListModel = MovieModel.fromJsonList(mockData);

      // Then
      expect(movieListModel.length, 3);
    });

    test(
        'should return empty list '
        'from invalid json structure', () {
      // Given
      final mockData = mockMovieModelJson;

      // When
      final movieListModel = MovieModel.fromJsonList(mockData);

      // Then
      expect(movieListModel.length, 0);
    });
  });
}
