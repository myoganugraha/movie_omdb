import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/data/models/__mocks__/movie_model_mock.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/domain/usecases/__mocks__/movie_usecase_mock.dart';
import 'package:movie_app/domain/usecases/movie_usecase.dart';
import 'package:movie_app/presentation/dashboard/cubit/dashboard_cubit.dart';

void main() {
  late DashboardCubit dashboardCubit;
  late MovieUseCase mockMovieUsecase;

  setUp(() {
    mockMovieUsecase = MockMovieUsecase();
    dashboardCubit = DashboardCubit(movieUseCase: mockMovieUsecase);
  });

  tearDown(() {
    dashboardCubit.close();
  });

  group('DashboardCubit', () {
    group('getMovieBySearch', () {
      final result = MovieModel.fromJsonList(mockSearchResultJson);
      blocTest<DashboardCubit, DashboardState>(
        'emits [MovieSearchOnLoading, MovieSearchOnSuccess] when '
        'getMovieBySearch() return valid data',
        setUp: () =>
            when(() => mockMovieUsecase.getMovieBySearch('bat')).thenAnswer(
          (_) async => result,
        ),
        build: () => dashboardCubit,
        act: (cubit) => cubit.getMovieBySearch('bat'),
        expect: () => [
          isA<MovieSearchOnLoading>(),
          isA<MovieSearchOnSuccess>(),
        ],
        verify: (_) async {
          verify(() => mockMovieUsecase.getMovieBySearch('bat')).called(1);
        },
      );

      blocTest<DashboardCubit, DashboardState>(
        'emits [MovieSearchOnLoading, MovieSearchOnError] when '
        'getMovieBySearch() failed',
        setUp: () =>
            when(() => mockMovieUsecase.getMovieBySearch('bat')).thenThrow(
          Exception(),
        ),
        build: () => dashboardCubit,
        act: (cubit) => cubit.getMovieBySearch('bat'),
        expect: () => [
          isA<MovieSearchOnLoading>(),
          isA<MovieSearchOnError>(),
        ],
        verify: (_) async {
          verify(() => mockMovieUsecase.getMovieBySearch('bat')).called(1);
        },
      );
    });
  });
}
