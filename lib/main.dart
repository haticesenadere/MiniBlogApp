import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/article%20blocs/article_bloc.dart';
import 'package:miniblog/repository/article_repository.dart';
import 'package:miniblog/screens/homepage.dart';

void main() {
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider<ArticleBloc>(
              create: (context) =>
                  ArticleBloc(artcileRepository: ArtcileRepository()))
        ],
        child: const MaterialApp(
            debugShowCheckedModeBanner: false, home: HomePage())),
  );
}
