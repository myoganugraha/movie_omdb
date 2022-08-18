import 'package:kiwi/kiwi.dart';

abstract class InjectorSupport {
  static KiwiContainer container = KiwiContainer();

  static final T Function<T>([String name]) resolve = container.resolve;
}
