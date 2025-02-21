import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/error_messages.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_style.dart';

class CustomErrorBody extends StatelessWidget {
  const CustomErrorBody({
    super.key,
    required this.onRefresh,
  });

  final void Function() onRefresh;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.images.error,
          height: 0.4.sh,
        ),
        Text(
          ErrorMessages.errorOccurred,
          style: AppTextStyles.styleW600.copyWith(
            fontSize: 18.sp,
            color: AppColors.darkBlue,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20.h,
        ),
        Center(
          child: ElevatedButton(
            onPressed: onRefresh,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkBlue,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: Text(
                'Reload',
                textAlign: TextAlign.center,
                style: AppTextStyles.styleW600.copyWith(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
