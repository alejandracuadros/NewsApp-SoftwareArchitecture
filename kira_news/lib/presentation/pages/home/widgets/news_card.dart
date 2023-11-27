import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kira_news/data/news/response.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/theme/app_text_style.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.article});

  final Articles article;

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('MMMM dd, yyyy');
    final dateTime = DateTime.parse(article.publishedAt.toString());

    return InkWell(
      onTap: () {
        if (article.url != null) {
          launchUrl(Uri.parse(article.url!));
        }
      },
      child: Card(
        child: Column(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage ?? '',
                    // width: 100.r,
                    fit: BoxFit.cover,
                    errorWidget: (context, _, __) => Image.asset(
                      Assets.images.empty,
                      width: 100.r,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  child: Column(
                    children: [
                      Text(
                        '${article.title}',
                        style: AppTextStyles.styleW600.copyWith(
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    '${article.author}',
                                    style: AppTextStyles.styleW600.copyWith(
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(format.format(dateTime)),
                                ],
                              )
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark_add,
                              size: 32.r,
                              color: Colors.black,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
