import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_style.dart';
import '../pages/main/main_page.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key, required this.activeIndex})
      : super(key: key);

  final int activeIndex;

  void onTabTapped(int index) {
    bottomNavigationIndexNotifier.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: AppColors.primaryYellow,
      backgroundColor: Colors.white,
      selectedLabelStyle: AppTextStyles.styleW700.copyWith(
        fontSize: 14.sp,
        color: const Color(0xffF6CA5A),
      ),
      unselectedLabelStyle: AppTextStyles.styleW700.copyWith(
        fontSize: 14.sp,
        color: const Color(0xffA7A7A7),
      ),
      onTap: onTabTapped,
      currentIndex: activeIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: activeIndex == 0
                ? AppColors.primaryYellow
                : const Color(0xffA1A1A1),
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.category,
            color: activeIndex == 1
                ? AppColors.primaryYellow
                : const Color(0xffA1A1A1),
          ),
          label: "Category",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.bookmark,
            color: activeIndex == 2
                ? AppColors.primaryYellow
                : const Color(0xffA1A1A1),
          ),
          label: "Saved",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.notifications,
            color: activeIndex == 3
                ? AppColors.primaryYellow
                : const Color(0xffA1A1A1),
          ),
          label: "Notifications",
        ),
      ],
    );
  }
}
