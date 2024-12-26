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
  const MoviesLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class MoviesError extends MoviesState {
  final String message;
  const MoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
