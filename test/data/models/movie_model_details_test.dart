import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/data/models/__mocks__/movie_details_model_mock.dart';
import 'package:movie_app/data/models/movie_details_model.dart';

void main() {
  group('Movie details model', () {
    test(
        'should set the data '
        'from valid json', () {
      // Given
      final mockData = mockMovieDetailsModel;

      // When
      final movieDetailsModel = MovieDetailsModel.fromJson(mockData);

      // Then
      expect(movieDetailsModel.title, mockData['Title']);
      expect(movieDetailsModel.year, mockData['Year']);
      expect(movieDetailsModel.imdbID, mockData['imdbID']);
      expect(movieDetailsModel.type, mockData['Type']);
      expect(movieDetailsModel.poster, mockData['Poster']);
    });
  });
}
