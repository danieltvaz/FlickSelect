// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_movies/entity/movie.dart';
import 'package:my_movies/models/tmdb/tmdb-api-interface.dart';

import '../../utils/index.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  List<dynamic> providers = [];
  bool isAlreadyFetched = false;

  Future<dynamic> setProviders() async {
    if (!isAlreadyFetched) {
      var fetchedProviders =
          await TmdbApiInterface().getMovieProviders(widget.movie.id);
      setState(() {
        isAlreadyFetched = true;
        providers = fetchedProviders;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 600,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.movie.posterUrl, scale: 0.5),
              fit: BoxFit.fitHeight)),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: isAlreadyFetched ? 200 : 110,
            child: Container(
              padding: EdgeInsets.only(top: 4),
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.tag,
                        color: Colors.yellowAccent,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        widget.movie.title,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        color: Colors.yellowAccent,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Lançado em ${Utils.formatDate(widget.movie.releaseDate)}",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rate,
                        color: Colors.yellowAccent,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Nota ${widget.movie.rate}",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setProviders();
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.visibility,
                              color: Colors.yellowAccent,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              'Onde assistir',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  if (isAlreadyFetched)
                    SizedBox(
                      height: 12,
                    ),
                  Row(
                    children: [
                      if (providers.isEmpty && isAlreadyFetched)
                        Text(
                          'Nenhum provedor para assistir no Brasil.',
                          style: TextStyle(color: Colors.white),
                        ),
                      if (providers.isNotEmpty)
                        ...providers.map((e) => Image(
                              width: 72,
                              image: NetworkImage(
                                "https://image.tmdb.org/t/p/w500${e['logo_path']}",
                              ),
                            )),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
