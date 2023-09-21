// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:my_movies/entity/genre.dart';

import '../../models/tmdb/tmdb-api-interface.dart';

class ScreenContainer extends StatefulWidget {
  final List<Widget> widgets;
  final String title;
  Function(int? val) handleGenreChange;

  ScreenContainer(
      {super.key,
      required this.widgets,
      this.title = '',
      required this.handleGenreChange});

  @override
  State<ScreenContainer> createState() => _ScreenContainerState();
}

class _ScreenContainerState extends State<ScreenContainer> {
  Future<List<dynamic>>? _genres;
  Object? selectedGenre;

  @override
  void initState() {
    super.initState();
    _genres = getGenresList();
  }

  Future<List<dynamic>> getGenresList() async {
    final genresList = await TmdbApiInterface().getMoviesGenres();
    return genresList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          }),
          actions: [Icon(Icons.search)],
        ),
        drawer: SafeArea(
          child: Drawer(
            backgroundColor: Colors.black.withOpacity(0.8),
            child: ListView(
              children: [
                FutureBuilder(
                  future: _genres,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final genres = snapshot.data as List<dynamic>;

                      return Column(
                        children: [
                          OutlinedButton(
                            style: ButtonStyle(
                                side: MaterialStateBorderSide.resolveWith(
                                    (states) => BorderSide(
                                        color: Colors.orangeAccent))),
                            onPressed: () {
                              widget.handleGenreChange(null);
                            },
                            child: Text(
                              'Limpar filtros',
                              style: TextStyle(color: Colors.orangeAccent),
                            ),
                          ),
                          ...genres.map(
                            (e) {
                              return ListTile(
                                title: Text(
                                  e['name'],
                                  style: TextStyle(color: Colors.white),
                                ),
                                leading: Radio(
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.orangeAccent),
                                  value: e['id'],
                                  groupValue: selectedGenre,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGenre = value;
                                      widget.handleGenreChange(value);
                                    });
                                  },
                                ),
                              );
                            },
                          ).toList(),
                        ],
                      );
                    }
                    return Text('Carregando');
                  },
                )
              ],
            ),
          ),
        ),
        body: SafeArea(child: Column(children: [...widget.widgets])));
  }
}
