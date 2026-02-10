import 'package:colors_blind/app.dart';
import 'package:colors_blind/core/di/main_di.dart';
import 'package:colors_blind/core/services/localization/localization_constants.dart';
import 'package:colors_blind/core/services/upload_image/supabase/utils/supabase_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> _appInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();

  initDI();
  await SupabaseHelper.init();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );
}


void main() async {
  await _appInit();
  runApp(
    EasyLocalization(
      supportedLocales: LocalizationConstants.supportedLocales,
      path: LocalizationConstants.assetsPath,
      fallbackLocale: LocalizationConstants.fallbackLocale,
      child: ColorsBlind(),
    ),
  );
}

