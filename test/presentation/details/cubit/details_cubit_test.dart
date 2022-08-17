import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/data/models/__mocks__/movie_details_model_mock.dart';
import 'package:movie_app/data/models/movie_details_model.dart';
import 'package:movie_app/domain/usecases/__mocks__/movie_usecase_mock.dart';
import 'package:movie_app/domain/usecases/movie_usecase.dart';
import 'package:movie_app/presentation/details/cubit/details_cubit.dart';

void main() {
  late DetailsCubit detailsCubit;
  late MovieUseCase mockMovieUsecase;

  setUp(() {
    mockMovieUsecase = MockMovieUsecase();
    detailsCubit = DetailsCubit(movieUseCase: mockMovieUsecase);
  });

  tearDown(() {
    detailsCubit.close();
  });

  group('DetailsCubit', () {
    group('getMovieDetailsByImdbId', () {
      final result = MovieDetailsModel.fromJson(mockMovieDetailsModel);
      blocTest<DetailsCubit, DetailsState>(
        'emits [FetchDetailsOnLoading, FetchDetailsOnSuccess] when '
        'getMovieBySearch() return valid data',
        setUp: () =>
            when(() => mockMovieUsecase.getMovieDetailsByImdbId('tt0372784'))
                .thenAnswer(
          (invocation) async => result,
        ),
        build: () => detailsCubit,
        act: (cubit) => cubit.getMovieDetailsByImdbId('tt0372784'),
        expect: () => [
          isA<FetchDetailsOnLoading>(),
          isA<FetchDetailsOnSuccess>(),
        ],
        verify: (_) async {
          verify(() => mockMovieUsecase.getMovieDetailsByImdbId('tt0372784'))
              .called(1);
        },
      );

      blocTest<DetailsCubit, DetailsState>(
        'emits [FetchDetailsOnLoading, FetchDetailsOnError] when '
        'getMovieBySearch() failed',
        setUp: () => when(() => mockMovieUsecase.getMovieDetailsByImdbId('bat'))
            .thenThrow(
          Exception(),
        ),
        build: () => detailsCubit,
        act: (cubit) => cubit.getMovieDetailsByImdbId('tt0372784'),
        expect: () => [
          isA<FetchDetailsOnLoading>(),
          isA<FetchDetailsOnError>(),
        ],
        verify: (_) async {
          verify(() => mockMovieUsecase.getMovieDetailsByImdbId('tt0372784'))
              .called(1);
        },
      );
    });
  });
}
