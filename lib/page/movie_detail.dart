import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:next_app_zadanie/bloc/movie_bloc.dart';
import 'package:next_app_zadanie/models/movie_model.dart';

class MovieDetail extends StatefulWidget {
  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final MovieBloc _moviesBloc = MovieBloc();
  late MovieModel model;

  @override
  void initState() {
    _moviesBloc.add(GetMovieList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)!.settings.arguments as Search;
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.grey[300],
            title: Text(
              'DETAIL',
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
              child: Text(
                '${model.year}',
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 24,
                ),
              )),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '${model.title}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 25,
                ),
              )),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: "${model.poster}",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ))
        ]))));
  }
}
