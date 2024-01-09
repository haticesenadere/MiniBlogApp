import 'package:flutter/material.dart';
import 'package:miniblog/blocs/article%20blocs/article_event.dart';
import 'package:miniblog/models/blog.dart';

abstract class ArticleDetailEvent {}

class FetchDetailarticlesid extends ArticleDetailEvent {
  final String detailblogId;

  FetchDetailarticlesid({required this.detailblogId});
}

class ResetDetailEvent extends ArticleDetailEvent {}

class ArticleAdd extends ArticlesEvent {
  final Blog blogadd;
  final BuildContext context;

  ArticleAdd({required this.blogadd, required this.context});
}
