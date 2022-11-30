import 'package:flutter/material.dart';
import 'package:hyperboliq/app/ui/app_colors.dart';
import 'package:hyperboliq/app/ui/text_styles.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: const [
            Icon(
              Icons.photo,
              size: 100,
              color: AppColors.grey,
            ),
            Text(
              "No Picture Selected",
              style: title,
            ),
            Text(
              "Please select a picture",
              style: subTitle,
            )
          ]),
    );
  }
}
