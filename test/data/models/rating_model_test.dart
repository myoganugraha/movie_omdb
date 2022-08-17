import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/data/models/__mocks__/rating_model_mock.dart';
import 'package:movie_app/data/models/rating_model.dart';

void main() {
  group('Rating model', () {
    test(
        'should set the data '
        'from valid json', () {
      // Given
      final mockData = mockRatingModelJson;

      // When
      final ratingModel = RatingModel.fromJson(mockData);

      // Then
      expect(ratingModel.source, mockData['Source']);
      expect(ratingModel.value, mockData['Value']);
    });
  });
}
