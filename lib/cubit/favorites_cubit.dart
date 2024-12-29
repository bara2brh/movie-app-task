import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState([]));

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesString = prefs.getString('favorites');
    final List<Map<String, dynamic>> favorites = favoritesString != null
        ? List<Map<String, dynamic>>.from(jsonDecode(favoritesString))
        : [];
    emit(FavoritesState(favorites));
  }

  Future<void> addFavorite(Map<String, dynamic> movie) async {
    final updatedFavorites = List<Map<String, dynamic>>.from(state.favorites)
      ..add(movie);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('favorites', jsonEncode(updatedFavorites));

    emit(FavoritesState(updatedFavorites));
  }

  Future<void> removeFavorite(Map<String, dynamic> movie) async {
    final updatedFavorites = List<Map<String, dynamic>>.from(state.favorites)
      ..removeWhere((m) => m['id'] == movie['id']);
    emit(FavoritesState(updatedFavorites));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('favorites', jsonEncode(updatedFavorites));

    emit(FavoritesState(updatedFavorites));
  }
}
