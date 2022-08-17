import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/data/models/__mocks__/movie_details_model_mock.dart';
import 'package:movie_app/data/models/__mocks__/movie_model_mock.dart';
import 'package:movie_app/data/models/movie_details_model.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/domain/repositories/__mock__/movie_repository_mock.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/movie_usecase.dart';

void main() {
  late MovieRepository mockMovieRepository;
  late MovieUseCase movieUseCase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    movieUseCase = MovieUseCase(movieRepository: mockMovieRepository);

    registerFallbackValue(List<MovieModel>);
  });

  group('Movie usecase', () {
    group('should get movie data', () {
      test('from repository', () async {
        // Given
        when(() => mockMovieRepository.getMovieBySearch('bat')).thenAnswer(
          (_) async => MovieModel.fromJsonList(mockSearchResultJson),
        );

        // When
        final response = await movieUseCase.getMovieBySearch('bat');

        // Then
        expect(response.length, 3);
        expect(response[0].title, 'Bat*21');
        expect(response[0].year, '1988');
        expect(response[0].type, 'movie');
      });
    });

    group('should get movie details data', () {
      test('from repository with imdb id: tt0372784', () async {
        // Given
        const imdbID = 'tt0372784';
        when(() => mockMovieRepository.getMovieDetailsByImdbId(imdbID))
            .thenAnswer(
          (_) async => MovieDetailsModel.fromJson(mockMovieDetailsModel),
        );

        // When
        final response = await movieUseCase.getMovieDetailsByImdbId(imdbID);

        //Then
        expect(response.title, 'Batman Begins');
        expect(response.year, '2005');
        expect(response.type, 'movie');
        expect(response.imdbID, 'tt0372784');
      });
    });
  });
}
