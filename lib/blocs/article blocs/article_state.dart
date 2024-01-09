// Proje articial inital durumunda olsun
// istek attığımda articleloadin olsun
//article loadded olsun

// Neden abstract ? Articlellerin durumu deyince soyut mu somut mu anlamak için
// bu durumları değiştiricek eventler gerekli.

//durumlar gerektiğinde içerisinde bilgi taşır.
import 'package:miniblog/models/blog.dart';

abstract class ArticleState {}

class ArticlesInitial extends ArticleState {}

class ArticlesLoading extends ArticleState {}

class ArticlesLoaded extends ArticleState {
  final List<Blog> blogs;
  ArticlesLoaded({required this.blogs});
}

class ArticlesError extends ArticleState {}
