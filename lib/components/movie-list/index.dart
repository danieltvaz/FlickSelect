import 'package:flutter/material.dart';

import '../../entity/movie.dart';
import '../movie-card/index.dart';

class MovieList extends StatefulWidget {
  final List<Movie>? movies;
  dynamic Function(String? atEdge)? atEdgeHandler;

  MovieList({super.key, this.movies, this.atEdgeHandler});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      final isAtEdge = _controller.position.atEdge;
      if (widget.atEdgeHandler != null) {
        if (isAtEdge) {
          if (_controller.position.pixels == 0) {
            widget.atEdgeHandler!('start');
          } else {
            widget.atEdgeHandler!('end');
          }
        }
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: ListView.builder(
      controller: _controller,
      itemCount: widget.movies?.length,
      itemBuilder: (context, index) {
        var currentMovie = widget.movies?[index];
        if (currentMovie != null) {
          return MovieCard(movie: currentMovie);
        }
        return const Text('Carregando...');
      },
    ));
  }
}
