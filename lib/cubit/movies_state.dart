import 'package:equatable/equatable.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object?> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<dynamic> movies;
  final bool isPagination;  // Flag to check if it's pagination or first load

  const MoviesLoaded(this.movies, {this.isPagination = false});

  @override
  List<Object?> get props => [movies, isPagination];
}

class MoviesError extends MoviesState {
  final String message;
  const MoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
