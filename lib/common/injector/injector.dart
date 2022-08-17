import 'package:kiwi/kiwi.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/data/datasources/remote/movie_remote_datasource.dart';
import 'package:movie_app/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/movie_usecase.dart';
import 'package:movie_app/presentation/dashboard/cubit/dashboard_cubit.dart';

part 'injector.g.dart';

abstract class Injector {
  static KiwiContainer? container;

  static void setup() {
    if (container == null) {
      container ??= KiwiContainer();
      _$Injector().configure();
    }
  }

  static final resolve = container?.resolve;

  void configure() {
    _configureBlocs();
    _configureUsecases();
    _configureRepositories();
    _configureRemoteDatasources();
  }

// ============ BLOCS / CUBITS ============
  @Register.singleton(DashboardCubit)
  void _configureBlocs();

// ============ USECASES ============
  @Register.singleton(MovieUseCase)
  void _configureUsecases();

// ============ REPOSITORIES ============
  @Register.singleton(
    MovieRepository,
    from: MovieRepositoryImpl,
  )
  void _configureRepositories();

// ============ REMOTE DATASOURCES ============
  @Register.singleton(MovieRemoteDatasource)
  void _configureRemoteDatasources();
}
