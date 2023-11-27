import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_style.dart';

class CustomEmptyBody extends StatelessWidget {
  const CustomEmptyBody({
    super.key,
    this.message = 'No result found',
    this.assetImage,
    this.mainAxisAlignment,
  });

  final String message;
  final String? assetImage;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        Image.asset(
          assetImage ?? Assets.images.empty,
          height: 0.3.sh,
          width: double.infinity,
        ),
        Text(
          message,
          style: AppTextStyles.styleW600.copyWith(
            fontSize: 18.sp,
            color: AppColors.darkBlue,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
