import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kira_news/core/constants/assets.dart';
import 'package:kira_news/presentation/widgets/custom_empty_body.dart';
import '../../../core/theme/app_text_style.dart';
import '../../widgets/custom_navigation_bar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavigationBar(activeIndex: 3),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Notifications', style: AppTextStyles.styleW600),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 0.1.sh),
        child: CustomEmptyBody(
          assetImage: Assets.gifs.emptyNotificationGif,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      // BlocBuilder<GetNotificationsCubit, GetNotificationsState>(
      //   builder: (context, state) {
      //     if (state is GetNotificationsSuccess) {
      //       final notificationList = state.list;
      //       if (notificationList.isEmpty) {
      //         return const Center(
      //           child: Text('Bildirisiniz yoxdur'),
      //         );
      //       }
      //       return RefreshIndicator(
      //         onRefresh: () =>
      //             context.read<GetNotificationsCubit>().getNotifications(),
      //         child: ListView.separated(
      //           padding: EdgeInsets.symmetric(vertical: 22.h),
      //           itemCount: notificationList.length,
      //           itemBuilder: (context, index) => NotificationItem(
      //             message: notificationList[index].message!,
      //           ),
      //           separatorBuilder: (context, index) => Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 30).r,
      //             child: Divider(
      //               color: const Color(0xffBFBFBF).withOpacity(0.22),
      //               height: 20,
      //               thickness: 1,
      //             ),
      //           ),
      //         ),
      //       );
      //     }
      //     if (state is GetNotificationsFailure) {
      //       return Center(
      //         child: Text(state.message),
      //       );
      //     }
      //     return Padding(
      //       padding: const EdgeInsets.only(top: 20).r,
      //       child: const Center(
      //         child: CircularProgressIndicator(),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
