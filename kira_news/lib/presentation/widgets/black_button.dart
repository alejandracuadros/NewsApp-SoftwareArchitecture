import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_style.dart';

class BlackButton extends StatelessWidget {
  const BlackButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.child,
    this.isLoading = false,
    this.bacgroundColor = AppColors.darkBlue,
  }) : super(key: key);

  final String text;
  final void Function()? onTap;
  final Widget? child;
  final bool isLoading;
  final Color bacgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onTap == null || isLoading ? Colors.grey : bacgroundColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: isLoading ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10).r,
          child: SizedBox(
            width: double.infinity,
            height: 34.h,
            child: Center(child: Builder(
              builder: (context) {
                if (isLoading) {
                  return const CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  );
                } else if (child != null) {
                  return child!;
                }
                return Text(
                  text,
                  style: AppTextStyles.styleW600.copyWith(
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            )),
          ),
        ),
      ),
    );
  }
}
