import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kira_news/data/news/response.dart';
import '../../../core/theme/app_text_style.dart';
import '../../widgets/custom_empty_body.dart';
import '../../widgets/custom_navigation_bar.dart';
import '../home/widgets/news_card.dart';

class SavedNewsPage extends StatelessWidget {
  const SavedNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const CustomNavigationBar(activeIndex: 2),
      appBar: AppBar(
        title: Text('Saved', style: AppTextStyles.styleW600),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('favorites')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final articles = snapshot.data!.docs
                .map((query) => Articles.fromFirestore(query.data()))
                .toList();
            if (articles.isEmpty) {
              return const CustomEmptyBody(
                message: 'You have no saved news',
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) => NewsCard(
                article: articles[index],
                isInSaved: true,
              ),
              itemCount: articles.length,
            );
          }
          return const Center(
            child: SpinKitCircle(
              size: 50,
              color: Colors.blue,
            ),
          );
        },
      ),
    );
  }
}
