import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_text_style.dart';

class CustomTextFieldErrorMessage extends StatelessWidget {
  const CustomTextFieldErrorMessage({
    Key? key,
    required this.streamController,
  }) : super(key: key);

  final StreamController<List<dynamic>?>? streamController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<dynamic>?>(
      stream: streamController!.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Padding(
            padding: const EdgeInsets.only(top: 5, left: 12).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                snapshot.data!.length,
                (index) => Text(
                  snapshot.data?[index],
                  style: AppTextStyles.styleW500
                      .copyWith(fontSize: 10.sp, color: Colors.red),
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
