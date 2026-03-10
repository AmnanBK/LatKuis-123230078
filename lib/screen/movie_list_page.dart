import 'package:flutter/material.dart';
import 'package:latihan_kuis_a/models/movie_model.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movies")),
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

class _MovieCard extends StatelessWidget {
  final MovieModel movie;

  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _MoviePoster(imgUrl: movie.imgUrl),
            const SizedBox(width: 12),
            Expanded(child: _MovieInfo(movie: movie)),
          ],
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

  const _MovieInfo({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MovieTitleRow(movie: movie),
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

  const _MovieTitleRow({required this.movie});

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
        IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_border)),
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
