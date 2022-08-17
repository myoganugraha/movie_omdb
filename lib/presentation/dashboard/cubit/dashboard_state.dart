part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class MovieSearchOnLoading extends DashboardState {}

class MovieSearchOnSuccess extends DashboardState {
  MovieSearchOnSuccess(this.movieList);

  final List<MovieEntity> movieList;
}

class MovieSearchOnError extends DashboardState {
  MovieSearchOnError(this.message);

  final dynamic message;
}
