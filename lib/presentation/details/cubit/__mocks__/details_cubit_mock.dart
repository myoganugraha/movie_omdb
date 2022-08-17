import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/presentation/details/cubit/details_cubit.dart';

class FakeDetailsState extends Fake implements DetailsState{}

class MockDetailsCubit extends MockCubit<DetailsState>
    implements DetailsCubit {
  static void setUp() {
    registerFallbackValue(FakeDetailsState());
  }
}
