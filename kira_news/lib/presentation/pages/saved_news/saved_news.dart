import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../data/news/cubit/get_news_cubit.dart';
import '../../widgets/custom_empty_body.dart';
import '../../widgets/custom_error_body.dart';
import '../../widgets/custom_navigation_bar.dart';
import 'widgets/saved_news_card.dart';

class SavedNewsPage extends StatelessWidget {
  const SavedNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavigationBar(activeIndex: 2),
      appBar: AppBar(
        title: Text('Saved', style: AppTextStyles.styleW600),
      ),
      body: BlocBuilder<GetNewsCubit, GetNewsState>(
        builder: (context, state) {
          if (state is GetNewsSuccess) {
            final articles = state.articles;
            if (articles.isEmpty) {
              return const CustomEmptyBody();
            }
            return RefreshIndicator(
              onRefresh: context.read<GetNewsCubit>().getNews,
              child: ListView.builder(
                itemBuilder: (context, index) => SavedNewsCard(
                  article: articles[index],
                ),
                itemCount: articles.length,
              ),
            );
          }
          if (state is GetNewsFailure) {
            return CustomErrorBody(
              onRefresh: context.read<GetNewsCubit>().getNews,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
