import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/domain/entities/__mocks__/rating_entity.dart';

void main() {
  group('Rating entity', () {
    test('should init rating entity correctly', () {
      // Given
      const source = 'Google';
      const value = '8.0/10';

      // When
      final ratingEntity = mockRatingEntity;

      // Then
      expect(ratingEntity.source, source);
      expect(ratingEntity.value, value);
    });
  });
}
