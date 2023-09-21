import 'package:flutter/material.dart';
import 'package:my_movies/components/movie-list/index.dart';
import 'package:my_movies/components/screen-container/index.dart';
import 'package:my_movies/entity/movie.dart';
import 'package:my_movies/screens/home-screen/model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenModel(),
      child: Consumer<HomeScreenModel>(
        builder: (context, value, child) {
          return FutureBuilder(
            future: value.getMoviesList(),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text(
                  snapshot.error.toString(),
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      decoration: TextDecoration.none),
                );
              }

              return ScreenContainer(
                handleGenreChange: (newGenre) {
                  value.genre = newGenre;
                },
                widgets: [
                  MovieList(
                    atEdgeHandler: (atEdge) {
                      if (atEdge == 'end') {
                        value.nextPage();
                      } else {
                        value.backPage();
                      }
                    },
                    movies: snapshot.data?.map((rawMovie) {
                      return Movie.fromJson(rawMovie);
                    }).toList(),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
