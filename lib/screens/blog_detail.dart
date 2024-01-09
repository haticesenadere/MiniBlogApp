// ... (import statements)

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/detail_bloc/artical_detail_bloc.dart';
import 'package:miniblog/blocs/detail_bloc/article_detail_event.dart';
import 'package:miniblog/blocs/detail_bloc/article_detail_state.dart';

class BlogDetail extends StatefulWidget {
  const BlogDetail({Key? key, required this.detailblogId}) : super(key: key);

  final String detailblogId;

  @override
  _BlogDetailState createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Blog İçeriği",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.deepOrangeAccent],
            ),
          ),
        ),
      ),
      body: BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
        builder: (context, state) {
          if (state is ArticlesDetailInitial) {
            print("yükleniyor");

            context
                .read<ArticleDetailBloc>()
                .add(FetchDetailarticlesid(detailblogId: widget.detailblogId));
            // UI'dan BLOC'a Event
            return const Center(child: Text("İstek atıldı"));
          }
          if (state is ArticlesDetailLoading) {
            print("ArticlesDetailLoading");

            return const Center(child: CircularProgressIndicator());
          }
          if (state is ArticlesDetailLoaded) {
            print("loaded");

            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            state.detailblogsid.thumbnail ??
                                "", // Null check added
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 300,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        state.detailblogsid.title ?? "", // Null check added
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        children: [
                          Text(
                            "${state.detailblogsid.author}", // Null check added
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " ${state.detailblogsid.content ?? ""}", // Null check added
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is ArticlesDetailError) {
            return const Center(
              child: Text("Bloglar yüklenirken hata oldu"),
            );
          }
          return const Center(
            child: Text("hata"),
          );
        },
      ),
    );
  }
}
