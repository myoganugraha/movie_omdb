part of 'details_cubit.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class FetchDetailsOnLoading extends DetailsState {}

class FetchDetailsOnSuccess extends DetailsState {
  FetchDetailsOnSuccess(this.movieDetailsData);

  final MovieDetailsEntity movieDetailsData;
}

class FetchDetailsOnError extends DetailsState {
  FetchDetailsOnError(this.message);

  final dynamic message;
}
