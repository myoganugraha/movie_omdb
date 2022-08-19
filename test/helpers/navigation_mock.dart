import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

import '../mock.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {
  static void setUp() {
    registerFallbackValue(FakeRoute());
  }
}
