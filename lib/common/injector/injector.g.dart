// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: cascade_invocations

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureBlocs() {
    final container = KiwiContainer();
    container
      ..registerSingleton(
        (c) => DashboardCubit(movieUseCase: c<MovieUseCase>()),
      )
      ..registerSingleton((c) => DetailsCubit(movieUseCase: c<MovieUseCase>()));
  }

  @override
  void _configureUsecases() {
    final container = KiwiContainer();
    container.registerSingleton(
      (c) => MovieUseCase(movieRepository: c<MovieRepository>()),
    );
  }

  @override
  void _configureRepositories() {
    final container = KiwiContainer();
    container.registerSingleton<MovieRepository>(
      (c) => MovieRepositoryImpl(
        movieRemoteDatasource: c<MovieRemoteDatasource>(),
      ),
    );
  }

  @override
  void _configureRemoteDatasources() {
    final container = KiwiContainer();
    container.registerSingleton((c) => MovieRemoteDatasource(c<Client>()));
  }

  @override
  void _configureHttpClient() {
    final container = KiwiContainer();
    container.registerSingleton((c) => Client());
  }
}
