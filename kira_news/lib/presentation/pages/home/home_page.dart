import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kira_news/data/news/cubit/get_news_cubit.dart';
import 'package:kira_news/presentation/pages/home/widgets/news_card.dart';
import 'package:kira_news/presentation/widgets/custom_empty_body.dart';
import 'package:kira_news/presentation/widgets/custom_error_body.dart';

import '../../../core/theme/app_text_style.dart';
import '../../widgets/custom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<GetNewsCubit>().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavigationBar(activeIndex: 0),
      appBar: AppBar(
        title: Text('News', style: AppTextStyles.styleW600),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings),
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'Log out',
                child: Row(
                  children: [
                    const Icon(Icons.logout),
                    SizedBox(
                      width: 4.w,
                    ),
                    const Text('Log out'),
                  ],
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ),
        ],
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
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index == 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 20).r,
                        child: Text(
                          'BBC news',
                          style: AppTextStyles.styleW700.copyWith(
                            fontSize: 26.sp,
                          ),
                        ),
                      ),
                    NewsCard(article: articles[index]),
                  ],
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
          return const Center(
              child: SpinKitCircle(
            size: 50,
            color: Colors.blue,
          ));
        },
      ),
    );
  }
}
