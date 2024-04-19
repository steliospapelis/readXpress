import 'package:flutter/material.dart';
import 'package:readxpress2/themes/app_styles.dart';
import 'package:readxpress2/themes/theme_config.dart';
import 'package:readxpress2/themes/text_styles.dart';
import 'package:readxpress2/themes/image_paths.dart';
import 'package:readxpress2/widgets/image_view.dart';
import 'package:readxpress2/themes/sizes.dart';

class SmallBookCardWidget extends StatelessWidget {
  final String title;
  final String author;
  final String imagePath;
  final double progress;

  const SmallBookCardWidget({
    required this.title,
    required this.author,
    required this.imagePath,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20.h,
        right: 26.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 5.v,
      ),
      decoration: AppDecoration.outlineBlue.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder20,
      ),
      child: Column(
        
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgIconsMore24px,
            height: 24.adaptSize,
            width: 24.adaptSize,
            alignment: Alignment.topCenter,
          ),
          SizedBox(
            width: 86.h,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: ThemeHelper()
                  .themeData()
                  .textTheme
                  .bodyMedium!
                  .copyWith(height: 1.43),
            ),
          ),
          SizedBox(height: 3.v),
          Text(
            author,
            style: CustomTextStyles.bodySmallGray900018,
          ),
          CustomImageView(
            imagePath: imagePath,
            height: 111.v,
            width: 85.h,
          ),
          SizedBox(height: 9.v),
          Container(
            height: 4.v,
            width: 85.h,
            decoration: BoxDecoration(
              color: appTheme.blue50,
            ),
            child: ClipRRect(
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: appTheme.blue50,
                valueColor: AlwaysStoppedAnimation<Color>(
                  appTheme.amberA700,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
        ],
      ),
    );
  }
}