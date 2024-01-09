import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:miniblog/blocs/article%20blocs/article_bloc.dart';
import 'package:miniblog/blocs/article%20blocs/article_event.dart';
import 'package:miniblog/blocs/article%20blocs/article_state.dart';

import 'package:miniblog/repository/article_repository.dart';
import 'package:miniblog/screens/add_blog.dart';
import 'package:miniblog/widgets/blog_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.orangeAccent, Colors.deepOrangeAccent]),
            ),
          ),
          title: const Text(
            "Blog",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
          actions: [
            IconButton(
                color: Colors.white,
                onPressed: () async {
                  bool? result = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const AddBlog()));
                  if (result == true) {
                    context.read<ArticleBloc>().add(fetcArticles());
                  }
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: BlocProvider(
          create: (context) =>
              ArticleBloc(artcileRepository: ArtcileRepository()),
          child:
              BlocBuilder<ArticleBloc, ArticleState>(builder: (context, state) {
            if (state is ArticlesInitial) {
              //bloca fetcharticila göndericem
              context.read<ArticleBloc>().add(fetcArticles());
              return const Center(child: Text("İstek atılıyor"));
            }
            if (state is ArticlesLoaded) {
              return ListView.builder(
                  itemCount: state.blogs.length,
                  itemBuilder: (context, index) =>
                      BlogItem(blog: state.blogs[index]));
            }
            if (state is ArticlesLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Center(
              child: Text("Unknown State"),
            );
          }),
        ));
  }
}
