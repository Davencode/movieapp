import 'package:equatable/equatable.dart';
import 'package:movieapp/DataModel/movieModel.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieInitialState extends MovieState {}

class MovieLoadingState extends MovieState {}

class MovieLoadedState extends MovieState {
  final List<MovieModel> movies;

  MovieLoadedState(this.movies);

  @override
  List<Object?> get props => [movies];
}

class MovieErrorState extends MovieState {
  final String message;

  MovieErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
