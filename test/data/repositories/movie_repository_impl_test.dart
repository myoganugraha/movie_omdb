import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/data/datasources/remote/__mocks__/movie_remote_datasource_mock.dart';
import 'package:movie_app/data/datasources/remote/movie_remote_datasource.dart';
import 'package:movie_app/data/models/__mocks__/movie_model_mock.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/repositories/movie_repository_impl.dart';

void main() {
  late MovieRemoteDatasource mockMovieRemoteDatasource;
  late MovieRepositoryImpl movieRepositoryImpl;

  setUp(() {
    mockMovieRemoteDatasource = MockMovieRemoteDatasource();
    movieRepositoryImpl =
        MovieRepositoryImpl(movieRemoteDatasource: mockMovieRemoteDatasource);
  });

  group('Movie reposiotry impl', () {
    group('should get movie data', () {
      test('from remote datasource', () async {
        // Given
        final mockData = MovieModel.fromJsonList(mockSearchResultJson);

        when(() => mockMovieRemoteDatasource.getMovieBySearch('bat'))
            .thenAnswer((data) async => mockData);

        // When
        final response = await movieRepositoryImpl.getMovieBySearch('bat');

        // Then
        expect(response.length, 3);
        expect(response[0].title, 'Bat*21');
        expect(response[0].year, '1988');
        expect(response[0].type, 'movie');
      });
    });
  });
}
