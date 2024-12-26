import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repositories/movies_repository.dart';
import 'movies_state.dart';


class MoviesCubit extends Cubit<MoviesState> {
  final MovieRepository movieRepository;

  MoviesCubit(this.movieRepository) : super(MoviesInitial());

  void fetchMovies() async {
    emit(MoviesLoading());
    try {
      final movies = await movieRepository.fetchMovies();
      emit(MoviesLoaded(movies));
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }
}
