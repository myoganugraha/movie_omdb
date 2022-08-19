// ignore_for_file: omit_local_variable_types, strict_raw_type

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/common/injector/injector_support.dart';
import 'package:movie_app/data/models/__mocks__/movie_details_model_mock.dart';
import 'package:movie_app/data/models/movie_details_model.dart';
import 'package:movie_app/domain/entities/__mocks__/movie_entity_mock.dart';
import 'package:movie_app/presentation/dashboard/cubit/__mocks__/dashboard_cubit_mock.dart';
import 'package:movie_app/presentation/dashboard/cubit/dashboard_cubit.dart';
import 'package:movie_app/presentation/dashboard/view/dashboard_page.dart';
import 'package:movie_app/presentation/dashboard/view/dashboard_view_constants.dart';
import 'package:movie_app/presentation/details/cubit/__mocks__/details_cubit_mock.dart';
import 'package:movie_app/presentation/details/cubit/details_cubit.dart';
import 'package:movie_app/presentation/details/view/details_page.dart';

import '../../../helpers/helpers.dart';
import '../../../mock.dart';

void main() {
  late MockNavigatorObserver mockObserver;
  late DashboardCubit dashboardCubit;
  late DetailsCubit detailsCubit;

  setUpAll(() {
    MockDashboardCubit.setUp();
    MockDetailsCubit.setUp();
    FakeRoute.setUp();
  });

  setUp(() {
    mockObserver = MockNavigatorObserver();
    InjectorSupport.container
        .registerInstance<DashboardCubit>(MockDashboardCubit());
    dashboardCubit = InjectorSupport.resolve<DashboardCubit>();

    InjectorSupport.container
        .registerInstance<DetailsCubit>(MockDetailsCubit());
    detailsCubit = InjectorSupport.resolve<DetailsCubit>();

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
  });

  tearDown(() {
    dashboardCubit.close();
    detailsCubit.close();
    InjectorSupport.container.clear();
  });

  Future<void> _buildDashboardPage(
    WidgetTester tester,
  ) async {
    await tester.pumpApp(
      const DashboardPage(),
      observer: mockObserver,
    );
  }

  group('DashboardPage', () {
    testWidgets('render screen with message when state is DashboardInitial()',
        (tester) async {
      // Given
      when(() => dashboardCubit.state).thenAnswer((_) => DashboardInitial());

      await _buildDashboardPage(tester);

      // When
      final List<ValueKey> _keyToFind = [
        DashboardViewConstants.messageContainerKey,
      ];

      // Then
      for (final element in _keyToFind) {
        final bodyChildWidgetFinder = find.byKey(element);

        expect(bodyChildWidgetFinder, findsOneWidget);
      }
    });

    testWidgets(
        'render screen with loading when state is MovieSearchOnLoading()',
        (tester) async {
      // Given
      when(() => dashboardCubit.state)
          .thenAnswer((_) => MovieSearchOnLoading());

      await _buildDashboardPage(tester);

      // When
      final List<ValueKey> _keyToFind = [
        DashboardViewConstants.onLoadingContainerKey,
        DashboardViewConstants.onLoadingSpinnerKey,
      ];

      // Then
      for (final element in _keyToFind) {
        final bodyChildWidgetFinder = find.byKey(element);

        expect(bodyChildWidgetFinder, findsOneWidget);
      }
    });

    testWidgets('render screen show data when state is MovieSearchOnSuccess()',
        (tester) async {
      // Given
      when(() => dashboardCubit.state).thenAnswer(
        (_) => MovieSearchOnSuccess([mockMovieEntity]),
      );

      await _buildDashboardPage(tester);

      // When
      final content =
          find.byKey(ValueKey('${mockMovieEntity.imdbID}_content_key'));

      //Then
      expect(content, findsOneWidget);
    });

    testWidgets('onTap() item when MovieSearchOnSuccess()', (tester) async {
      // Given
      when(() => dashboardCubit.state).thenAnswer(
        (_) => MovieSearchOnSuccess([mockMovieEntity]),
      );
      await _buildDashboardPage(tester);

      // When
      final item =
          find.byKey(ValueKey('${mockMovieEntity.imdbID}_content_key'));

      await tester.tap(item);
      await tester.pumpAndSettle();

      //Then
      expect(find.byType(DetailsPage), findsOneWidget);
    });

    testWidgets(
        'render screen show error text when state is MovieSearchOnError()',
        (tester) async {
      // Given
      when(() => dashboardCubit.state).thenAnswer(
        (_) => MovieSearchOnError('Error'),
      );

      await _buildDashboardPage(tester);

      // When
      final List<ValueKey> _keyToFind = [
        DashboardViewConstants.messageContainerKey,
        DashboardViewConstants.messageTextKey,
      ];

      // Then
      for (final element in _keyToFind) {
        final bodyChildWidgetFinder = find.byKey(element);
        //Then
        expect(bodyChildWidgetFinder, findsOneWidget);
      }
    });

    testWidgets('listen user input ', (tester) async {
      // Given
      when(() => dashboardCubit.getMovieBySearch('batman'))
          .thenAnswer((_) async {});

      when(() => dashboardCubit.state).thenAnswer(
        (_) => MovieSearchOnSuccess([mockMovieEntity]),
      );

      await _buildDashboardPage(tester);

      // When
      final TextField searchField = find
          .byKey(DashboardViewConstants.searchFieldKey)
          .evaluate()
          .first
          .widget as TextField;
      searchField.controller!.text = 'batman';
      searchField.onChanged!('batman');

      await tester.pump(const Duration(milliseconds: 800));

      // Then
      verify(() => dashboardCubit.getMovieBySearch('batman')).called(1);
    });
  });
}
