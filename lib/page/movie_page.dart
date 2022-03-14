import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_app_zadanie/bloc/movie_bloc.dart';
import 'package:next_app_zadanie/models/movie_model.dart';
import 'movie_detail.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final MovieBloc _moviesBloc = MovieBloc();

  @override
  void initState() {
    _moviesBloc.add(GetMovieList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[300],
          title: Text(
            '10 MOVIES WITH BATMAN',
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
      body: _buildListMovie(),
    );
  }

  Widget _buildListMovie() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _moviesBloc,
        child: BlocListener<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is MovieError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieInitial) {
                return _buildLoading();
              } else if (state is MovieLoading) {
                return _buildLoading();
              } else if (state is MovieLoaded) {
                return _buildCard(context, state.movieModel);
              } else if (state is MovieError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, MovieModel model){
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(4, 4),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4, -4),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child:  ListTile(
              title: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${model.search![index].year}',
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      '${model.search![index].title}',
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child:  Icon(
                      Icons.read_more,
                      color: Colors.grey[900],
                      size: 20.0,
                    ),
                  ),
                ],
              ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetail(),
                      settings: RouteSettings(arguments: model.search![index]),
                    ),
                  );
                },
              ),
            ),
          )
        );
      },
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}