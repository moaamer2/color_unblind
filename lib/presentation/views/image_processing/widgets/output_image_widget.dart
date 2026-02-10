import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';
import 'package:colors_blind/presentation/widgets/adaptive_loading_indicator.dart';
import 'package:colors_blind/presentation/widgets/points_loading_widget_indicator.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OutputImageWidget extends StatelessWidget {
  final bool isloading;
  final String? url;
  final bool hasError;

  const OutputImageWidget({
    super.key,
    this.isloading = false,
    required this.url,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.veryLightGrey,
        borderRadius: BorderRadius.circular(16.fromRadius),
      ),

      alignment: Alignment.center,
      child: url != null && !isloading && !hasError ? ClipRRect(
        borderRadius: BorderRadius.circular(16.fromRadius),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: url!,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 50.staticRadius,
                ),
                placeholder: (context, url) => AdaptiveLoadingIndicator(
                  androidSize: 21,
                  iOSsize: 11,
                  androidWidth: 4,
                  color: themeCubit.state.primaryColor,
                ),
              ),
            ),
          ],
        ),
      )
      : isloading ? Center(
        child: PointsLoadingWidgetIndicator(
          color: themeCubit.state.primaryColor,
          shadingColor: AppColors.grey,
          size: 12.fromRadius.max(20),
          countIndicators: 4,
        ),
      ) : hasError ? Center(
        child: Icon(
          Icons.error,
          color: Colors.red,
          size: 50.staticRadius,
        ),
      ) : Center(
        child: Icon(
          Icons.image,
          color: AppColors.grey,
          size: 50.staticRadius,
        ),
      ),
    );
  }
}
