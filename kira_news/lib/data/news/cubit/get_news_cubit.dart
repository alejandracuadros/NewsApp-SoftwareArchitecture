import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/error_messages.dart';
import '../response.dart';
import '../repository.dart';

part 'get_news_state.dart';

class GetNewsCubit extends Cubit<GetNewsState> {
  GetNewsCubit() : super(const GetNewsInitial());

  final NewsRepository repository = NewsRepository();

  Future<void> getNews() async {
    if (state is! GetNewsSuccess) {
      emit(const GetNewsLoading());
    }

    try {
      String channelName = 'bbc-news';

      final response =
          await repository.fetchNewsChannelHeadlinesApi(channelName);

      if (response.status == "ok") {
        emit(
          GetNewsSuccess(response.articles ?? []),
        );
      } else {
        emit(
          GetNewsFailure(response.status!),
        );
      }
    } catch (_) {
      emit(
        const GetNewsFailure(ErrorMessages.errorOccurred),
      );
    }
  }
}
