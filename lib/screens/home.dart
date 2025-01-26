import 'package:assignment3/bloc/news_blocs.dart';
import 'package:assignment3/bloc/news_events.dart';
import 'package:assignment3/bloc/news_states.dart';
import 'package:assignment3/models/news_model.dart';
import 'package:assignment3/repository/news_repositories.dart';
import 'package:assignment3/widgets/news_list_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(
        RepositoryProvider.of<NewsRepository>(context),
      )..add(LoadNewsEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Online/Offline Newspaper'),
        ),
        body: BlocConsumer<NewsBloc, NewsState>(
          listener: (context, state) {
            if (state is NewsErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is NewsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is NewsLoadedState) {
              return buildNews(context, state.news);
            }

            return const Center(child: Text("No data available."));
          },
        ),
      ),
    );
  }

  Widget buildNews(BuildContext context, List<NewsModel>? news) {
    if (news == null || news.isEmpty) {
      return const Center(child: Text("No news available."));
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ListView.builder(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.025, vertical: width * 0.01),
      itemCount: news.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return NewsListWidgets(
          heigth: height * 0.451,
          width: width,
          padding: width * 0.03,
          title: news[index].title,
          description: news[index].description,
          author: news[index].author ?? 'Unknown',
          content: news[index].content ?? 'No content available',
          publishedAt: news[index].publishedAt ?? 'Unknown date',
          url: news[index].url,
          urlToImage: news[index].urlToImage ?? '',
        );
      },
    );
  }
}
