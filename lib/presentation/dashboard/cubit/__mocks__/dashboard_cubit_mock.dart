import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/presentation/dashboard/cubit/dashboard_cubit.dart';

class FakeDashboardState extends Fake implements DashboardState{}

class MockDashboardCubit extends MockCubit<DashboardState>
    implements DashboardCubit {
  static void setUp() {
    registerFallbackValue(FakeDashboardState());
  }
}
