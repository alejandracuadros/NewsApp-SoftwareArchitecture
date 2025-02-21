import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kira_news/presentation/pages/notification/notification_page.dart';
import 'package:kira_news/presentation/pages/saved_news/saved_news.dart';
import '../category/category_page.dart';
import '../home/home_page.dart';
import '../login/login.dart';

final ValueNotifier<int> bottomNavigationIndexNotifier = ValueNotifier(0);

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _pages = [
    const HomePage(),
    const CategoryPage(),
    const SavedNewsPage(),
    const NotificationPage()
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ValueListenableBuilder(
            valueListenable: bottomNavigationIndexNotifier,
            builder: (context, value, child) =>
                _pages[bottomNavigationIndexNotifier.value],
          );
        }
        return const LoginPage();
      },
    );
  }
}
