import '../../core/models/categories_news_model.dart';
import 'response.dart';
import 'service.dart';

class NewsRepository {
  final _rep = NewsService();

  Future<GetNewsResponse> fetchNewsChannelHeadlinesApi(
      String channelName) async {
    final response = await _rep.fetchNewsChannelHealinesApi(channelName);
    return response;
  }

  Future<NewsCategoryResponse> fetchCategoriesNewsApi(String category) async {
    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;
  }
}
