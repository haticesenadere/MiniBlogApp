import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/detail_bloc/article_detail_event.dart';
import 'package:miniblog/blocs/detail_bloc/article_detail_state.dart';
import 'package:miniblog/repository/article_repository.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  final ArtcileRepository artcileRepository;

  ArticleDetailBloc({
    required this.artcileRepository,
  }) : super(ArticlesDetailInitial()) {
    on<FetchDetailarticlesid>(_onFetcDetailArticleesid);
    on<ResetDetailEvent>(_onResetDetailArticleesid);
  }

  void _onFetcDetailArticleesid(
      FetchDetailarticlesid event, Emitter<ArticleDetailState> emit) async {
    final String blogID = event.detailblogId;
    emit(ArticlesDetailLoading());

    try {
      final articlesid = await artcileRepository.fetchBlogDetay(blogID);
      emit(ArticlesDetailLoaded(detailblogsid: articlesid));
    } catch (e) {
      emit(ArticlesDetailError());
    }
  }

  void _onResetDetailArticleesid(
      ResetDetailEvent event, Emitter<ArticleDetailState> emit) async {
    emit(ArticlesDetailInitial());
  }
}
