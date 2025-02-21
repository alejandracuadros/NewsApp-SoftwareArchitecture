import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kira_news/core/constants/assets.dart';
import 'package:kira_news/core/models/notification_model.dart';
import 'package:kira_news/presentation/pages/notification/widgets/notification_item.dart';
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
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('notifications')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final notifications = snapshot.data!.docs
                  .map((query) => NotificationModel.fromFirestore(query.data()))
                  .toList();
              if (notifications.isEmpty) {
                return CustomEmptyBody(
                  message: 'You have no notifications',
                  assetImage: Assets.gifs.emptyNotificationGif,
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) => NotificationItem(
                  message: notifications[index].message,
                ),
                itemCount: notifications.length,
              );
            }
            return const Center(
              child: SpinKitCircle(
                size: 50,
                color: Colors.blue,
              ),
            );
          },
        ));
  }
}
