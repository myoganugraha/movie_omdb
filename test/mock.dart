import 'package:mocktail/mocktail.dart';

class FakeUri extends Fake implements Uri {
  static void setUp() => registerFallbackValue(FakeUri());
}
