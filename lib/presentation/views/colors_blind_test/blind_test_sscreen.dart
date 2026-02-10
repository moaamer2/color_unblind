import 'package:colors_blind/core/extensions/context/navigation.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/core/helper/app_constants.dart';
import 'package:colors_blind/core/services/localization/locale_keys.g.dart';
import 'package:colors_blind/core/services/url_lancher/url_lancher_service.dart';
import 'package:colors_blind/presentation/style/app_text_styles.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';
import 'package:colors_blind/presentation/widgets/custom_points_loading_widget.dart';
import 'package:colors_blind/presentation/widgets/my_sub_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlindTestSscreen extends StatefulWidget {
  const BlindTestSscreen({
    super.key,
  });

  @override
  State<BlindTestSscreen> createState() => _BlindTestSscreenState();
}

class _BlindTestSscreenState extends State<BlindTestSscreen> {
  @override
  void initState(){
    super.initState();
    launchUrl(AppConstants.colorsBlindTestUrl,);
  }

  Future<void> launchUrl(String url) async {
    await UrlLanchService.openUrl(url);

    
    // ignore: use_build_context_synchronously
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Scaffold(
      backgroundColor: themeCubit.state.backgroundColor,
    
      appBar: MySubAppbar(
        title: context.tr(LocaleKeys.colorsBlindTest),
        titleStyle: AppTextStyles.appBarTitle.copyWith(
          color: themeCubit.state.textColor,
          fontSize: 25.textScale,
        ),
      ),
    
    
      body: Center(
        child: CustomPointsLoadingWidget(),
      ),
    );
  }
}
