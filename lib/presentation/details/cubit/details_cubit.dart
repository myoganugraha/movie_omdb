import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/domain/entities/movie_details_entity.dart';
import 'package:movie_app/domain/usecases/movie_usecase.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit({required this.movieUseCase}) : super(DetailsInitial());
  final MovieUseCase movieUseCase;

  Future<void> getMovieDetailsByImdbId(String imdbId) async {
    try {
      emit(FetchDetailsOnLoading());
      final data = await movieUseCase.getMovieDetailsByImdbId(imdbId);
      emit(FetchDetailsOnSuccess(data));
    } catch (e) {
      emit(FetchDetailsOnError(e));
    }
  }
}
