import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

class FakeUri extends Fake implements Uri {
  static void setUp() => registerFallbackValue(FakeUri());
}

class FakeRoute extends Fake implements Route<dynamic> {
  static void setUp() => registerFallbackValue(FakeRoute());
}
