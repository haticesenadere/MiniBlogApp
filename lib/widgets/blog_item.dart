import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/detail_bloc/artical_detail_bloc.dart';
import 'package:miniblog/blocs/detail_bloc/article_detail_event.dart';
import 'package:miniblog/models/blog.dart';
import 'package:miniblog/repository/article_repository.dart';
import 'package:miniblog/screens/blog_detail.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({super.key, required this.blog});

  final Blog blog;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            AspectRatio(
                //resimlerim sınırlanması sağlar.
                aspectRatio: 4 / 2,
                child: Container(
                    width: double.infinity,
                    color: const Color.fromRGBO(245, 216, 163, 0.612),
                    child: Center(child: Image.network(blog.thumbnail!)))),
            ListTile(
              tileColor: const Color.fromARGB(255, 246, 227, 199),
              focusColor: Colors.orange,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 8, color: Colors.orange),
                borderRadius: BorderRadius.circular(20),
              ),
              autofocus: true,
              title: Text(
                blog.title!,
                style: const TextStyle(
                  fontFamily: AutofillHints.jobTitle,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                blog.author!,
                style: const TextStyle(
                  fontFamily: AutofillHints.jobTitle,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        context.read<ArticleDetailBloc>().add(ResetDetailEvent());

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const BlogDetail(
                  detailblogId: '',
                )));
      },
    );
  }
}
