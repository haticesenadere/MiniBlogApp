import 'package:miniblog/models/blog.dart';

abstract class ArticleDetailState {}

class ArticlesDetailInitial extends ArticleDetailState {}

class ArticlesDetailLoaded extends ArticleDetailState {
  final Blog detailblogsid;
  ArticlesDetailLoaded({required this.detailblogsid});
}

class ArticlesDetailLoading extends ArticleDetailState {}

class ArticlesDetailError extends ArticleDetailState {}
