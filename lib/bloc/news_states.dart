import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../models/news_model.dart';

@immutable
abstract class NewsState extends Equatable {}

class NewsLoadingState extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsLoadedState extends NewsState {
  NewsLoadedState(this.news);

  final List<NewsModel> news;

  @override
  List<Object?> get props => [news];
}

class NewsErrorState extends NewsState {
  NewsErrorState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
