import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/movies.dart';
import '../repositories/movies_repository.dart';
import 'movies_state.dart';
class MoviesCubit extends Cubit<MoviesState> {
  final MovieRepository movieRepository;
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  MoviesCubit(this.movieRepository) : super(MoviesInitial());

  List<dynamic> allMovies = [];

  void fetchMovies({bool isPagination = false}) async {
    try {
      if (!isPagination) emit(MoviesLoading());

      final Movies newMovies = await movieRepository.fetchMovies(
        page: isPagination ? (allMovies.length ~/ 20) + 1 : 1,
      );

      if (newMovies.results == null || newMovies.results!.isEmpty) {
        if (isPagination) {
          emit(MoviesLoaded(allMovies));
        } else {
          emit(MoviesError('No movies found.'));
        }
        return;
      } else {
        if (isPagination) {
          allMovies.addAll(newMovies.results!);
        } else {
          allMovies = newMovies.results!;
        }


        emit(MoviesLoaded(allMovies, isPagination: isPagination));
      }

    } catch (e) {
      emit(MoviesError('Failed to load movies.'));
    }
  }




 void updateSearchQuery(String query) {
    searchQuery = query;
    emit(MoviesLoaded(filterMovies()));
  }

  void clearSearchQuery() {
    searchController.clear();
    searchQuery = '';
    emit(MoviesLoaded(allMovies));
  }

  List filterMovies() {
    return allMovies.where((movie) {
      return movie['title'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }
}