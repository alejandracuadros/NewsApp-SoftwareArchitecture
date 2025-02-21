import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kira_news/core/theme/app_colors.dart';
import 'package:kira_news/core/theme/app_text_style.dart';
import 'package:kira_news/presentation/widgets/save_news_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/models/categories_news_model.dart';
import '../../../data/news/repository.dart';
import '../../widgets/custom_navigation_bar.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  NewsRepository newsViewModel = NewsRepository();

  final format = DateFormat('MMMM dd, yyyy');

  String categoryName = 'general';

  List<String> categoriesList = [
    'general',
    'entertainment',
    'health',
    'sports',
    'business',
    'technology'
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Category', style: AppTextStyles.styleW600),
      ),
      bottomNavigationBar: const CustomNavigationBar(activeIndex: 1),
      body: Column(children: [
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
            height: 50.r,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoriesList.length,
              itemBuilder: ((context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    categoryName = categoriesList[index];
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: categoryName == categoriesList[index]
                            ? AppColors.primaryYellow
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Center(
                            child: Text(
                          categoriesList[index].toString(),
                          style: GoogleFonts.poppins(
                              fontSize: 13, color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                );
              }),
            )),
        SizedBox(height: 10.h),
        Expanded(
          child: FutureBuilder<NewsCategoryResponse>(
            future: newsViewModel.fetchCategoriesNewsApi(categoryName),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: SpinKitCircle(
                  size: 50,
                  color: Colors.blue,
                ));
              } else {
                final articles = snapshot.data!.articles!;
                return ListView.builder(
                  itemCount: snapshot.data!.articles!.length,
                  padding: const EdgeInsets.all(10).r.r,
                  itemBuilder: (context, index) {
                    DateTime dateTime =
                        DateTime.parse(articles[index].publishedAt.toString());
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        InkWell(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          onTap: articles[index].url != null
                              ? () {
                                  launchUrl(Uri.parse(articles[index].url!));
                                }
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        articles[index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    height: height * .18,
                                    width: width * .3,
                                    placeholder: (context, url) =>
                                        const SpinKitCircle(
                                      size: 50,
                                      color: Colors.blue,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error_outline,
                                            color: Colors.red),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  height: height * .18,
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        articles[index].title.toString(),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: 0.4.sw,
                                        child: Text(
                                          articles[index]
                                              .source!
                                              .name
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Text(
                                        format.format(dateTime),
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                        AddRemoveNewsButton(article: articles[index]),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ]),
    );
  }
}
