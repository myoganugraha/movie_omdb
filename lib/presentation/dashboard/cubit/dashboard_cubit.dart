import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/usecases/movie_usecase.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({required this.movieUseCase}) : super(DashboardInitial());

  final MovieUseCase movieUseCase;

  Future<void> getMovieBySearch(String query) async {
    try {
      emit(MovieSearchOnLoading());
      final data = await movieUseCase.getMovieBySearch(query);
      emit(MovieSearchOnSuccess(data));
    } catch (e) {
      emit(MovieSearchOnError(e));
    }
  }
}
