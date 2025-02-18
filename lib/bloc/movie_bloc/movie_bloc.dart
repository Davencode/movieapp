import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:movieapp/Repositories/movie_repository.dart';
import 'package:movieapp/bloc/movie_bloc/movie_state.dart';
import 'movie_event.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {

  final MovieRepository repository;

  MovieBloc(this.repository) : super(MovieInitialState()) {
    on<MovieLoadedEvent>((event, emit) async {
      emit(MovieLoadingState());

      try {
        final movies = await repository.getMovies();
        emit(MovieLoadedState(movies));
      } catch (e) {
        emit(MovieErrorState("Errore nel caricamento: ${e.toString()}"));
      }
    });
  }
}
