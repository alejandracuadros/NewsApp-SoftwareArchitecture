import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kira_news/data/news/response.dart';
import 'package:kira_news/presentation/widgets/save_news_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/theme/app_text_style.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.article,
    this.isInSaved = false,
  });

  final Articles article;
  final bool isInSaved;

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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 16)
                          .r,
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
                                  const Icon(
                                    Icons.person,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  SizedBox(
                                    width: 0.6.sw,
                                    child: Text(
                                      '${article.author}',
                                      style: AppTextStyles.styleW600.copyWith(
                                        fontSize: 15.sp,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
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
                          const Spacer(),
                          AddRemoveNewsButton(
                            article: article,
                            remove: isInSaved,
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
