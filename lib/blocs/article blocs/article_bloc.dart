import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/article%20blocs/article_event.dart';
import 'package:miniblog/blocs/article%20blocs/article_state.dart';
import 'package:miniblog/repository/article_repository.dart';

class ArticleBloc extends Bloc<ArticlesEvent, ArticleState> {
  final ArtcileRepository artcileRepository;

  ArticleBloc({required this.artcileRepository})
      : super(
            ArticlesInitial()) // uygulama ilk açıldığında articleİntial durumunda açılıcak.
  {
    on<fetcArticles>(_onFetchArticles);
  }

  void _onFetchArticles(fetcArticles event, Emitter<ArticleState> emit) async {
    emit(ArticlesLoading());
    try {
      final articles = await artcileRepository.fetchBlogs();
      emit(ArticlesLoaded(blogs: articles));
    } catch (e) {
      emit(ArticlesError());
    }
  }
}
//Eventleri tanımldık. State'i tanımladık. Ve değiştiriceğim yeri bağladım.