import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/assets.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30).r,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none_outlined,
              color: AppColors.primaryYellow,
              size: 36.r,
            ),
            SizedBox(
              width: 6.w,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AnimatedSize(
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        widget.message,
                        style: AppTextStyles.styleW500.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.darkBlue,
                        ),
                        maxLines: isExpanded == false ? 1 : null,
                        overflow:
                            isExpanded == false ? TextOverflow.ellipsis : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6).r,
                    child: SvgPicture.asset(
                      isExpanded
                          ? Assets.icons.arrowUp
                          : Assets.icons.arrowDown,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}
