import 'movie_model.dart';

class SavedMovies {
  static final List<MovieModel> _savedMovies = [];

  static List<MovieModel> get savedMovies => _savedMovies;

  static bool isSaved(MovieModel movie) {
    return _savedMovies.contains(movie);
  }

  static void toggle(MovieModel movie) {
    if (isSaved(movie)) {
      _savedMovies.remove(movie);
    } else {
      _savedMovies.add(movie);
    }
  }
}
