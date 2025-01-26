import 'package:assignment3/bloc/news_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/news_repositories.dart';
import 'news_states.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;

  NewsBloc(this._newsRepository) : super(NewsLoadingState()) {
    on<LoadNewsEvent>((event, emit) async {
      emit(NewsLoadingState());

      try {
        final news = await _newsRepository.getArticles();
        emit(NewsLoadedState(news));
      } catch (e) {
        emit(NewsErrorState('Failed to fetch news. Showing offline data.'));
      }
    });
  }
}