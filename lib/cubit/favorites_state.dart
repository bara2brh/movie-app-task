import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  final List<Map<String, dynamic>> favorites;

  const FavoritesState(this.favorites);

  @override
  List<Object?> get props => [favorites];
}
