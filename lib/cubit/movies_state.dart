import 'package:equatable/equatable.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object?> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {
  final bool isPagination;
  const MoviesLoading({this.isPagination = false});

  @override
  List<Object?> get props => [isPagination];
}

class MoviesLoaded extends MoviesState {
  final List<dynamic> movies;
  final bool isPagination;

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
