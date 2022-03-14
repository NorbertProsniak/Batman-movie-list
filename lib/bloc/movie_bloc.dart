import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:next_app_zadanie/models/movie_model.dart';
import 'package:next_app_zadanie/resources/api_repository.dart';

part 'movie_state.dart';
part 'movie_event.dart';


class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetMovieList>((event, emit) async {
      try {
        emit(MovieLoading());
        final mList = await _apiRepository.fetchMovieList();
        emit(MovieLoaded(mList));
        if (mList.error != null) {
          emit(MovieError(mList.error));
        }
      } on NetworkError {
        emit(MovieError("Failed to fetch data. is your device online?"));
      }
    });
  }
}