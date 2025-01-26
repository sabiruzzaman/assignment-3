import 'dart:convert';
import 'package:http/http.dart';
import '../models/news_model.dart';
import '../database/database_helper.dart';

class NewsRepository {
  final String endPoint = "https://newsapi.org/v2/top-headlines?country=us&apiKey=39a7657faa7f43d8bfa31229208147d0";
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<NewsModel>> getArticles() async {
    try {
      Response response = await get(Uri.parse(endPoint));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)['articles'];
        List<NewsModel> news = result.map((e) => NewsModel.fromJson(e)).toList();

        // Save data to local database
        await _dbHelper.insertNews(news);

        return news;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      // Fetch from local storage if there's an error
      return await _dbHelper.getNews();
    }
  }
}
