import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/domain/entities/__mocks__/movie_details_entity_mock.dart';

void main() {
  group('Movie details entity', () {
    test('should init movie details entity correctly', () {
      // Given
      const title = 'title';
      const year = 'year';
      const rated = 'rated';
      const released = 'released';
      const language = 'language';
      const poster = 'poster';
      const type = 'type';

      // When
      final movieDetailsEntity = mockMovieDetailsEntity;

      // Then
      expect(movieDetailsEntity.title, title);
      expect(movieDetailsEntity.year, year);
      expect(movieDetailsEntity.rated, rated);
      expect(movieDetailsEntity.released, released);
      expect(movieDetailsEntity.language, language);
      expect(movieDetailsEntity.poster, poster);
      expect(movieDetailsEntity.type, type);
    });
  });
}
