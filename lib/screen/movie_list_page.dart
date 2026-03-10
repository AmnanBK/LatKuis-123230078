import 'package:flutter/material.dart';
import 'package:latihan_kuis_a/models/movie_model.dart';
import 'package:latihan_kuis_a/models/saved_movies.dart';
import 'package:latihan_kuis_a/screen/movie_detail.dart';

class MovieListPage extends StatelessWidget {
  final String username;

  const MovieListPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome, $username")),
      body: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          final movie = movieList[index];
          return _MovieCard(movie: movie);
        },
      ),
    );
  }
}

class _MovieCard extends StatefulWidget {
  final MovieModel movie;

  const _MovieCard({required this.movie});

  @override
  State<_MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<_MovieCard> {
  void toggleBookmark() {
    setState(() {
      SavedMovies.toggle(widget.movie);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSaved = SavedMovies.isSaved(widget.movie);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailPage(movie: widget.movie),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _MoviePoster(imgUrl: widget.movie.imgUrl),
              const SizedBox(width: 12),
              Expanded(
                child: _MovieInfo(
                  movie: widget.movie,
                  isSaved: isSaved,
                  onBookmarkPressed: toggleBookmark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final String imgUrl;

  const _MoviePoster({required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.network(imgUrl, width: 80, height: 80, fit: BoxFit.cover),
    );
  }
}

class _MovieInfo extends StatelessWidget {
  final MovieModel movie;
  final bool isSaved;
  final VoidCallback onBookmarkPressed;

  const _MovieInfo({
    required this.movie,
    required this.isSaved,
    required this.onBookmarkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MovieTitleRow(
          movie: movie,
          isSaved: isSaved,
          onBookmarkPressed: onBookmarkPressed,
        ),
        const SizedBox(height: 4),
        Text(movie.genre, style: TextStyle(color: Colors.grey[700])),
        const SizedBox(height: 6),
        _MovieRating(rating: movie.rating),
      ],
    );
  }
}

class _MovieTitleRow extends StatelessWidget {
  final MovieModel movie;
  final bool isSaved;
  final VoidCallback onBookmarkPressed;

  const _MovieTitleRow({
    required this.movie,
    required this.isSaved,
    required this.onBookmarkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "${movie.title} (${movie.year})",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        IconButton(
          onPressed: onBookmarkPressed,
          icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
          color: isSaved ? Colors.blue : Colors.grey,
        ),
      ],
    );
  }
}

class _MovieRating extends StatelessWidget {
  final double rating;

  const _MovieRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.orange, size: 18),
        const SizedBox(width: 4),
        Text("$rating/10"),
      ],
    );
  }
}
