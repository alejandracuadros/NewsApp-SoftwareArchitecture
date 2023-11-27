import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kira_news/core/helper_functions.dart';
import 'package:kira_news/core/theme/app_colors.dart';
import 'package:kira_news/data/news/response.dart';

class AddRemoveNewsButton extends StatefulWidget {
  const AddRemoveNewsButton({
    Key? key,
    required this.article,
    this.remove = false,
  }) : super(key: key);

  final Articles article;
  final bool remove;

  @override
  State<AddRemoveNewsButton> createState() => _AddRemoveNewsButtonState();
}

class _AddRemoveNewsButtonState extends State<AddRemoveNewsButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: IconButton(
        splashRadius: 0.1,
        onPressed: () async {
          if (isLoading) {
            return;
          }

          if (mounted) {
            setState(() {
              isLoading = true;
            });
          }
          if (widget.remove) {
            await handleRemovingMovieFromFavorites();
          } else {
            await handleAddingMovieToFavorites();
          }

          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        },
        icon: (() {
          if (isLoading) {
            return SizedBox(
              height: 20.h,
              width: 20.w,
              child: const CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }

          return Icon(
            widget.remove ? Icons.bookmark_remove : Icons.bookmark_add,
            size: 30.r,
          );
        }()),
      ),
    );
  }

  Future<void> handleRemovingMovieFromFavorites() async {
    try {
      if (!(await doesMovieExistInFirestore())) {
        return;
      }
      await removeMovieFromFirestore();
    } on SocketException {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      showToast(message: 'No Internet Connection', color: Colors.red);
    } catch (_) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });

        showToast(message: 'Server Error Happened', color: Colors.red);
      }
    }
  }

  Future<void> handleAddingMovieToFavorites() async {
    try {
      if (await doesMovieExistInFirestore()) {
        showToast(
          message: 'News is already saved.',
          color: AppColors.primaryYellow,
        );
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        return;
      }

      await saveMovieToFirestore();

      showToast(
        message: 'News saved',
        color: Colors.green,
      );
    } on SocketException {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      showToast(
        message: 'No Internet Connection',
        color: Colors.red,
      );
    } catch (error) {
      print(error.toString());
      if (mounted) {
        setState(() {
          isLoading = false;
        });

        showToast(
          message: 'Server Error Happened',
          color: Colors.red,
        );
      }
    }
  }

  Future<bool> doesMovieExistInFirestore() async {
    final collectionReference = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('favorites');
    var querySnapshot = await collectionReference
        .where('title', isEqualTo: widget.article.title)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> saveMovieToFirestore() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('favorites')
        .add({
      'title': widget.article.title,
      'author': widget.article.author,
      'content': widget.article.content,
      'description': widget.article.description,
      'publishedAt': widget.article.publishedAt,
      'source': widget.article.source?.name,
      'url': widget.article.url,
      'urlToImage': widget.article.urlToImage,
      'datetime': DateTime.now(),
    });
  }

  Future<void> removeMovieFromFirestore() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('favorites')
        .where('title', isEqualTo: widget.article.title)
        .get()
        .then((querySnapshot) {
      String docId = querySnapshot.docs.first.id;

      return FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favorites')
          .doc(docId)
          .delete();
    });
  }
}
