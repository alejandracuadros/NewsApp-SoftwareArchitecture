import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/models/categories_news_model.dart';
import 'response.dart';

class NewsService {
  Future<GetNewsResponse> fetchNewsChannelHealinesApi(
      String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=227b721271b54f59b37211c4db65df6c';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return GetNewsResponse.fromJson(body);
    }
    throw Exception('Error');
  }

  Future<NewsCategoryResponse> fetchCategoriesNewsApi(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=${category}&apiKey=227b721271b54f59b37211c4db65df6c';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsCategoryResponse.fromJson(body);
    }
    throw Exception('Error');
  }
}
