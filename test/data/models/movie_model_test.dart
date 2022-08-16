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
  });
}
