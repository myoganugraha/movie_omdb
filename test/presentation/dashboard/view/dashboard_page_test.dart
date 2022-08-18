// ignore_for_file: omit_local_variable_types, strict_raw_type

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/common/injector/injector_support.dart';
import 'package:movie_app/domain/entities/__mocks__/movie_entity_mock.dart';
import 'package:movie_app/presentation/dashboard/cubit/__mocks__/dashboard_cubit_mock.dart';
import 'package:movie_app/presentation/dashboard/cubit/dashboard_cubit.dart';
import 'package:movie_app/presentation/dashboard/view/dashboard_page.dart';
import 'package:movie_app/presentation/dashboard/view/dashboard_view_constants.dart';

import '../../../helpers/helpers.dart';

void main() {
  late MockNavigatorObserver mockObserver;
  late DashboardCubit dashboardCubit;

  setUpAll(MockDashboardCubit.setUp);

  setUp(() {
    mockObserver = MockNavigatorObserver();
    InjectorSupport.container
        .registerInstance<DashboardCubit>(MockDashboardCubit());
    dashboardCubit = InjectorSupport.resolve<DashboardCubit>();
  });

  tearDown(() {
    dashboardCubit.close();
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
  });
}
