part of 'get_news_cubit.dart';

sealed class GetNewsState extends Equatable {
  const GetNewsState();

  @override
  List<Object> get props => [];
}

class GetNewsInitial extends GetNewsState {
  const GetNewsInitial();
}

class GetNewsLoading extends GetNewsState {
  const GetNewsLoading();
}

class GetNewsSuccess extends GetNewsState {
  final List<Articles> articles;

  const GetNewsSuccess(this.articles);
  @override
  List<Object> get props => [articles];
}

class GetNewsFailure extends GetNewsState {
  final String message;

  const GetNewsFailure(this.message);

  @override
  List<Object> get props => [message];
}
