// ignore_for_file: omit_local_variable_types, strict_raw_type
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/common/injector/injector_support.dart';
import 'package:movie_app/data/models/__mocks__/movie_details_model_mock.dart';
import 'package:movie_app/data/models/movie_details_model.dart';
import 'package:movie_app/domain/entities/__mocks__/movie_entity_mock.dart';
import 'package:movie_app/presentation/details/cubit/__mocks__/details_cubit_mock.dart';
import 'package:movie_app/presentation/details/cubit/details_cubit.dart';
import 'package:movie_app/presentation/details/view/details_page.dart';
import 'package:movie_app/presentation/details/view/details_view_constants.dart';

import '../../../helpers/helpers.dart';

void main() {
  late MockNavigatorObserver mockObserver;
  late DetailsCubit detailsCubit;

  setUpAll(MockDetailsCubit.setUp);

  setUp(() {
    mockObserver = MockNavigatorObserver();
    InjectorSupport.container
        .registerInstance<DetailsCubit>(MockDetailsCubit());
    detailsCubit = InjectorSupport.resolve<DetailsCubit>();
    registerFallbackValue(DetailsState);
  });

  tearDown(() {
    detailsCubit.close();
    InjectorSupport.container.clear();
  });

  Future<void> _buildDetailsPage(
    WidgetTester tester,
  ) async {
    await tester.pumpApp(
      DetailsPage(
        movieEntity: mockMovieEntity,
      ),
      observer: mockObserver,
    );
  }

  group('DetailsPage', () {
    testWidgets(
        'render screen with linear progress indicator '
        'while FetchDetailsOnLoading()', (tester) async {
      // Given
      when(() => detailsCubit.getMovieDetailsByImdbId(any()))
          .thenAnswer((_) async {});

      when(() => detailsCubit.state).thenAnswer((_) => FetchDetailsOnLoading());

      await _buildDetailsPage(tester);

      // When
      final _keyToFind = find.byKey(DetailsViewConstants.linearProgressKey);

      // Then
      expect(
        _keyToFind,
        findsOneWidget,
      );
    });

    testWidgets(
        'render screen with movieDetails '
        'while FetchDetailsOnSuccess()', (tester) async {
      // Given
      when(() => detailsCubit.getMovieDetailsByImdbId(mockMovieEntity.imdbID))
          .thenAnswer((_) async {});
      whenListen(
        detailsCubit,
        Stream.fromIterable([
          FetchDetailsOnLoading(),
          FetchDetailsOnSuccess(
            MovieDetailsModel.fromJson(mockMovieDetailsModel),
          ),
        ]),
      );
      when(() => detailsCubit.state).thenAnswer(
        (_) => FetchDetailsOnSuccess(
          MovieDetailsModel.fromJson(mockMovieDetailsModel),
        ),
      );

      await _buildDetailsPage(tester);

      // When
      final List<ValueKey> _keyToFind = [
        DetailsViewConstants.detailsScaffoldKey,
        DetailsViewConstants.awardTitleKey,
        DetailsViewConstants.awardContentKey,
        DetailsViewConstants.ratedTitleKey,
        DetailsViewConstants.ratedContentKey,
        DetailsViewConstants.plotKey,
      ];
      await tester.pump();
      // Then
      for (final element in _keyToFind) {
        final bodyChildWidgetFinder = find.byKey(element);
        //Then
        expect(bodyChildWidgetFinder, findsOneWidget);
      }
    });

    testWidgets(
        'render screen with genre item '
        'while FetchDetailsOnSuccess()', (tester) async {
      // Given
      when(() => detailsCubit.getMovieDetailsByImdbId(mockMovieEntity.imdbID))
          .thenAnswer((_) async {});
      whenListen(
        detailsCubit,
        Stream.fromIterable([
          FetchDetailsOnLoading(),
          FetchDetailsOnSuccess(
            MovieDetailsModel.fromJson(mockMovieDetailsModel),
          ),
        ]),
      );
      when(() => detailsCubit.state).thenAnswer(
        (_) => FetchDetailsOnSuccess(
          MovieDetailsModel.fromJson(mockMovieDetailsModel),
        ),
      );


      // When
      final genreWidgetFinder = find.byKey(DetailsViewConstants.genreKey);
      
      await _buildDetailsPage(tester);
      expect(genreWidgetFinder, findsNothing);
      await tester.pump();

      //Then
      expect(genreWidgetFinder, findsOneWidget);
    });

    testWidgets(
        'render screen with linear progress indicator '
        'while FetchDetailsOnError()', (tester) async {
      // Given
      when(() => detailsCubit.getMovieDetailsByImdbId(mockMovieEntity.imdbID))
          .thenAnswer((_) async {});

      when(() => detailsCubit.state).thenAnswer((_) => FetchDetailsOnError(''));

      await _buildDetailsPage(tester);

      // When
      final _keyToFind = find.byKey(DetailsViewConstants.linearProgressKey);

      // Then
      expect(
        _keyToFind,
        findsOneWidget,
      );
    });
  });
}
